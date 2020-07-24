import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import '../data/api/github/github_client.dart';
import '../data/database/database.dart';
import '../data/preferences/blackout_preferences.dart';
import '../data/repository/batch_repository.dart';
import '../data/repository/change_repository.dart';
import '../data/repository/group_repository.dart';
import '../data/repository/home_repository.dart';
import '../data/repository/product_repository.dart';
import '../data/repository/user_repository.dart';
import '../data/secure/secure_storage.dart';
import '../features/batch/bloc/batch_bloc.dart';
import '../features/blackout/bloc/blackout_bloc.dart';
import '../features/blackout_drawer/bloc/drawer_bloc.dart';
import '../features/group/bloc/group_bloc.dart';
import '../features/home/bloc/home_bloc.dart';
import '../features/product/bloc/product_bloc.dart';
import '../features/settings/bloc/settings_bloc.dart';
import '../features/setup/bloc/setup_bloc.dart';
import '../features/speeddial/bloc/speed_dial_bloc.dart';
import '../main.dart';

Database database;
bool main = true;
bool import = true;
bool application = true;

void prepareMain() async {
  if (main) {
    sl.registerSingleton<BlackoutPreferences>(BlackoutPreferences(await SharedPreferences.getInstance()));
    sl.registerLazySingleton<BlackoutBloc>(() => BlackoutBloc(sl<BlackoutPreferences>(), sl<SecureStorage>()));
    sl.registerSingleton<SecureStorage>(SecureStorage());
    await registerDio();
    main = false;
  }
}

void prepareImport(String databasePassword) async {
  if (import) {
    database = Database(databasePassword);
    sl.registerLazySingleton<HomeRepository>(() => database.homeRepository);
    sl.registerLazySingleton<UserRepository>(() => database.userRepository);
    import = false;
  }
}

void prepareApplication(String databasePassword) async {
  if (application) {
    await prepareMain();
    await prepareImport(databasePassword);
    await registerDatabase();
    await registerBloc();
    application = true;
  }
}

void registerDio() async {
  var dio = Dio();
  sl.registerLazySingleton<GithubClient>(() => GithubClient(dio));
}

void prepareSetup() async {
  sl.registerLazySingleton<SetupBloc>(() => SetupBloc(sl<BlackoutPreferences>(), sl<SecureStorage>()));
}

void registerDatabase() async {
  sl.registerLazySingleton<GroupRepository>(() => database.groupRepository);
  sl.registerLazySingleton<ChangeRepository>(() => database.changeRepository);
  sl.registerLazySingleton<BatchRepository>(() => database.batchRepository);
  sl.registerLazySingleton<ProductRepository>(() => database.productRepository);
}

void registerBloc() async {
  sl.registerLazySingleton<SettingsBloc>(() => SettingsBloc(sl<BlackoutPreferences>(), sl<UserRepository>()));

  sl.registerLazySingleton<DrawerBloc>(() => DrawerBloc(sl<BlackoutPreferences>(), sl<HomeRepository>()));

  sl.registerLazySingleton<BatchBloc>(() => BatchBloc(sl<ChangeRepository>(), sl<BatchRepository>(), sl<BlackoutPreferences>()));
  sl.registerLazySingleton<ProductBloc>(() => ProductBloc(sl<GroupRepository>(), sl<BlackoutPreferences>(), sl<ProductRepository>()));
  sl.registerLazySingleton<GroupBloc>(() => GroupBloc(sl<GroupRepository>(), sl<BlackoutPreferences>()));
  sl.registerLazySingleton<HomeBloc>(() => HomeBloc(sl<BlackoutPreferences>(), sl<GroupRepository>(), sl<ProductRepository>()));
  sl.registerLazySingleton<SpeedDialBloc>(() => SpeedDialBloc(sl<ProductRepository>(), sl<BlackoutPreferences>(), sl<ChangeRepository>(), sl<GroupRepository>()));
}
