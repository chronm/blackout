import 'dart:io';

import 'package:Blackout/bloc/drawer/drawer_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/di/di.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final BlackoutPreferences blackoutPreferences;

  MainBloc(this.blackoutPreferences);

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitializeAppEvent) {
      User user = await blackoutPreferences.getUser();
      Home home = await blackoutPreferences.getHome();
      if (user == null || home == null) {
        File file = await getDatabasePath();
        if (file.existsSync()) {
          bool import = await showDialog<bool>(
            context: event.context,
            builder: (context) => AlertDialog(
              title: Text("Import database?"),
              actions: [
                FlatButton(
                  child: Text("Ja"),
                  onPressed: () => Navigator.pop(event.context, true),
                ),
                FlatButton(
                  child: Text("Nein"),
                  onPressed: () => Navigator.pop(event.context, false),
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
