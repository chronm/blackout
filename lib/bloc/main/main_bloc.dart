import 'dart:io';

import 'package:Blackout/bloc/drawer/drawer_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/di/di.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pub_semver/pub_semver.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final BlackoutPreferences blackoutPreferences;

  MainBloc(this.blackoutPreferences);

  @override
  MainState get initialState => InitialMainState();

  Future<bool> checkPermissions(BuildContext context) async {
    PermissionStatus status = await Permission.storage.status;
    if (await Permission.storage.shouldShowRequestRationale) {
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_TITLE),
          content: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_BODY),
          actions: [
            FlatButton(
              child: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_OKAY),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
    if (status.isUndetermined || status.isDenied) {
      status = await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      bool forward = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_TITLE),
          content: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_BODY),
          actions: [
            FlatButton(
              child: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_NOPE),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_OKAY),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
      );
      if (forward) await openAppSettings();
      return false;
    }
    if (status.isDenied || status.isPermanentlyDenied) return false;
    return true;
  }

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitializeAppEvent) {
      User user = await blackoutPreferences.getUser();
      Home home = await blackoutPreferences.getHome();
      if (user == null || home == null) {
        if (!await checkPermissions(event.context)) exit(0);
        File file = await getDatabasePath();
        if (file.existsSync()) {
          bool import = await showDialog<bool>(
            context: event.context,
            builder: (context) => AlertDialog(
              title: Text(S.of(context).MAIN_IMPORT_DATABASE),
              actions: [
                FlatButton(
                  child: Text(S.of(context).MAIN_IMPORT_DATABASE_CANCEL),
                  onPressed: () => Navigator.pop(event.context, false),
                ),
                FlatButton(
                  child: Text(S.of(context).MAIN_IMPORT_DATABASE_ACCEPT),
                  onPressed: () => Navigator.pop(event.context, true),
                ),
              ],
            ),
          );
          if (import) {
            await prepareDi();
            User user = await sl<UserRepository>().findOneByOtherFalse();
            Home home = await sl<HomeRepository>().findHomeByActiveTrue();
            await blackoutPreferences.setUser(user);
            await blackoutPreferences.setHome(home);
            yield* mapEventToState(event);
          }
        } else {
          await prepareDi();
          yield GoToSetup();
        }
      } else {
        if (!diReady) await prepareDi();
        sl<HomeBloc>().add(LoadAll());
        sl<DrawerBloc>().add(InitializeDrawer());
        yield GoToHome();
        Version currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
        Version latestVersion;
        try {
          latestVersion = Version.parse(await blackoutPreferences.getVersion());
        } on ArgumentError {
          latestVersion = Version.none;
        }
        if (latestVersion != Version.none && latestVersion < currentVersion) {
          yield ShowChangelog();
        }
        await blackoutPreferences.setVersion(currentVersion.toString());
      }
    }
  }
}
