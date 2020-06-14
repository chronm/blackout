import 'dart:io';

import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/di/di.dart';
import 'package:Blackout/features/blackout_drawer/bloc/drawer_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:super_enum/super_enum.dart';

part 'blackout_event.dart';

part 'blackout_state.dart';

class BlackoutBloc extends Bloc<BlackoutEvent, BlackoutState> {
  final BlackoutPreferences blackoutPreferences;

  BlackoutBloc(this.blackoutPreferences);

  @override
  BlackoutState get initialState => InitialMainState();

  Future<bool> appIsInitialized() async {
    User user = await blackoutPreferences.getUser();
    Home home = await blackoutPreferences.getHome();
    return user != null && home != null;
  }

  Stream<BlackoutState> goToHome() async* {
    await prepareApplication();
    sl<HomeBloc>().add(LoadAll());
    sl<DrawerBloc>().add(InitializeDrawer());
    yield GoToHome();
  }

  Stream<BlackoutState> maybeShowChangelog() async* {
    Version currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    Version latestVersion;
    try {
      latestVersion = Version.parse(await blackoutPreferences.getVersion());
    } on ArgumentError {
      latestVersion = Version.none;
    }
    if (latestVersion != Version.none && latestVersion < currentVersion) {
      yield ShowChangelog();
      await blackoutPreferences.setVersion(currentVersion.toString());
    }
  }

  @override
  Stream<BlackoutState> mapEventToState(BlackoutEvent event) async* {
    if (event is InitializeApp) {
      if (await appIsInitialized()) {
        yield* goToHome();
        yield* maybeShowChangelog();
      } else {
        if (await Permission.storage.shouldShowRequestRationale) {
          yield AskForStorageRationale();
        } else {
          yield* mapEventToState(CheckPermissions());
        }
      }
    }
    if (event is CheckPermissions) {
      if (await Permission.storage.isUndetermined || await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
      if (await Permission.storage.isPermanentlyDenied) {
        yield AskForRedirectToSettings();
        return;
      }
      if (await Permission.storage.isDenied) {
        yield* mapEventToState(EndApp());
      } else {
        File file = await getDatabasePath();
        if (file.existsSync()) {
          yield AskForImportDatabase();
        } else {
          await prepareApplication();
          yield GoToSetup();
        }
      }
    }
    if (event is ImportDatabase) {
      await prepareImport();
      User user = await sl<UserRepository>().findOneByOtherFalse();
      Home home = await sl<HomeRepository>().findHomeByActiveTrue();
      await blackoutPreferences.setUser(user);
      await blackoutPreferences.setHome(home);
      await prepareApplication();
      sl<HomeBloc>().add(LoadAll());
      yield GoToHome();
    }
    if (event is DropDatabaseAndSetup) {
      File file = await getDatabasePath();
      await prepareApplication();
      file.deleteSync();
      yield GoToSetup();
    }
    if (event is EndApp) {
      exit(0);
    }
  }
}
