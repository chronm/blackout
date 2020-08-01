import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: implementation_imports
import 'package:sqflite_common/src/exception.dart';
import 'package:super_enum/super_enum.dart';

import '../../../data/database/database.dart';
import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/home_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../data/secure/secure_storage.dart';
import '../../../di/di.dart';
import '../../../main.dart';
import '../../../models/home_card.dart';
import '../../blackout_drawer/cubit/drawer_cubit.dart';
import '../../home/cubit/home_cubit.dart';

part 'blackout_event.dart';
part 'blackout_state.dart';

class BlackoutCubit extends Cubit<BlackoutState> {
  final BlackoutPreferences blackoutPreferences;
  final SecureStorage secureStorage;

  BlackoutCubit(this.blackoutPreferences, this.secureStorage) : super(InitialMainState());

  Future<bool> _appIsInitialized() async {
    var user = await blackoutPreferences.getUser();
    var home = await blackoutPreferences.getHome();
    return user != null && home != null;
  }

  void _goToHome() async {
    var password = await secureStorage.getDatabasePassword();
    await prepareApplication(password);
    var home = await blackoutPreferences.getHome();
    var groups = await sl<GroupRepository>().findAllByHomeId(home.id);
    var products = await sl<ProductRepository>().findAllByHomeIdAndGroupIsNull(home.id);
    var cards = <HomeCard>[]
      ..addAll(products)
      ..addAll(groups)
      ..sort((a, b) => a.title.compareTo(b.title));
    sl<HomeCubit>().useCards(cards);
    sl<DrawerCubit>().initializeDrawer();
    emit(GoToHome());
  }

  void _importDatabaseOrGoToSetup() async {
    var file = File(await getDatabasePath());
    if (file.existsSync()) {
      emit(AskForImportDatabase());
    } else {
      await prepareSetup();
      emit(GoToSetup());
    }
  }

  void initializeApp() async {
    if (await Permission.storage.isGranted) {
      if (await _appIsInitialized()) {
        _goToHome();
        sl<HomeCubit>().routineCheck();
      } else {
        _importDatabaseOrGoToSetup();
      }
    } else {
      if (await Permission.storage.isUndetermined || await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
      if (await Permission.storage.isPermanentlyDenied) {
        emit(AskForRedirectToSettings());
        return;
      }
      if (await Permission.storage.isDenied) {
        endApp();
      } else {
        _importDatabaseOrGoToSetup();
      }
    }
  }

  void importDatabase(String password) async {
    await prepareApplication(password);
    try {
      var user = await sl<UserRepository>().findOneByActiveTrue();
      var home = await sl<HomeRepository>().findOneByActiveTrue();
      await blackoutPreferences.setUser(user);
      await blackoutPreferences.setHome(home);
      sl<HomeCubit>().loadAll();
      sl<DrawerCubit>().initializeDrawer();
      emit(GoToHome());
      sl<HomeCubit>().routineCheck();
    } on SqfliteDatabaseException {
      emit(AskForImportDatabase(wrongPassword: true));
    }
  }

  void dropDatabaseAndSetup() async {
    var file = File(await getDatabasePath());
    await prepareSetup();
    file.deleteSync();
    emit(GoToSetup());
  }

  void endApp() async {
    exit(0);
  }
}
