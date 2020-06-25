import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:super_enum/super_enum.dart';

import '../../../data/database/database.dart';
import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/home_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../di/di.dart';
import '../../../main.dart';
import '../../blackout_drawer/bloc/drawer_bloc.dart';
import '../../home/bloc/home_bloc.dart';

part 'blackout_event.dart';
part 'blackout_state.dart';

class BlackoutBloc extends Bloc<BlackoutEvent, BlackoutState> {
  final BlackoutPreferences blackoutPreferences;

  BlackoutBloc(this.blackoutPreferences);

  @override
  BlackoutState get initialState => InitialMainState();

  Future<bool> appIsInitialized() async {
    var user = await blackoutPreferences.getUser();
    var home = await blackoutPreferences.getHome();
    return user != null && home != null;
  }

  Stream<BlackoutState> goToHome() async* {
    await prepareApplication();
    sl<HomeBloc>().add(LoadAll());
    sl<DrawerBloc>().add(InitializeDrawer());
    yield GoToHome();
  }

  Stream<BlackoutState> maybeShowChangelog() async* {
    var currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    Version latestVersion;
    try {
      latestVersion = Version.parse(await blackoutPreferences.getVersion());
      // ignore: avoid_catching_errors
    } on ArgumentError {
      latestVersion = Version.none;
    }
    if (latestVersion != Version.none && latestVersion < currentVersion) {
      yield ShowChangelog();
      await blackoutPreferences.setVersion(currentVersion.toString());
    }
  }

  Future<bool> hasStoragePermission() async {
    return Permission.storage.isGranted;
  }

  Stream<BlackoutState> importDatabaseOrGoToSetup() async* {
    var file = await getDatabasePath();
    if (file.existsSync()) {
      yield AskForImportDatabase();
    } else {
      await prepareApplication();
      await prepareSetup();
      yield GoToSetup();
    }
  }

  @override
  Stream<BlackoutState> mapEventToState(BlackoutEvent event) async* {
    if (event is InitializeApp) {
      if (await hasStoragePermission()) {
        if (await appIsInitialized()) {
          yield* goToHome();
          yield* maybeShowChangelog();
        } else {
          yield* importDatabaseOrGoToSetup();
        }
      } else {
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
          yield* importDatabaseOrGoToSetup();
        }
      }
    }
    if (event is ImportDatabase) {
      await prepareImport();
      var user = await sl<UserRepository>().findOneByActiveTrue();
      var home = await sl<HomeRepository>().findOneByActiveTrue();
      await blackoutPreferences.setUser(user);
      await blackoutPreferences.setHome(home);
      await prepareApplication();
      sl<HomeBloc>().add(LoadAll());
      sl<DrawerBloc>().add(InitializeDrawer());
      yield GoToHome();
    }
    if (event is DropDatabaseAndSetup) {
      var file = await getDatabasePath();
      await prepareApplication();
      await prepareSetup();
      file.deleteSync();
      yield GoToSetup();
    }
    if (event is EndApp) {
      exit(0);
    }
  }
}
