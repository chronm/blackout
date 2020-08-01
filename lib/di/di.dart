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
import '../features/batch/cubit/batch_cubit.dart';
import '../features/blackout/cubit/blackout_cubit.dart';
import '../features/blackout_drawer/cubit/drawer_cubit.dart';
import '../features/group/cubit/group_cubit.dart';
import '../features/home/cubit/home_cubit.dart';
import '../features/product/cubit/product_cubit.dart';
import '../features/settings/cubit/settings_cubit.dart';
import '../features/setup/cubit/setup_cubit.dart';
import '../features/speeddial/cubit/speed_dial_cubit.dart';
import '../main.dart';

Database database;
bool main = true;
bool import = true;
bool application = true;

void prepareMain() async {
  if (main) {
    sl.registerSingleton<BlackoutPreferences>(BlackoutPreferences(await SharedPreferences.getInstance()));
    sl.registerLazySingleton<BlackoutCubit>(() => BlackoutCubit(sl<BlackoutPreferences>(), sl<SecureStorage>()));
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
    await registerCubit();
    application = true;
  }
}

void registerDio() async {
  var dio = Dio();
  sl.registerLazySingleton<GithubClient>(() => GithubClient(dio));
}

void prepareSetup() async {
  sl.registerLazySingleton<SetupCubit>(() => SetupCubit(sl<BlackoutPreferences>(), sl<SecureStorage>()));
}

void registerDatabase() async {
  sl.registerLazySingleton<GroupRepository>(() => database.groupRepository);
  sl.registerLazySingleton<ChangeRepository>(() => database.changeRepository);
  sl.registerLazySingleton<BatchRepository>(() => database.batchRepository);
  sl.registerLazySingleton<ProductRepository>(() => database.productRepository);
}

void registerCubit() async {
  sl.registerLazySingleton<SettingsCubit>(() => SettingsCubit(sl<BlackoutPreferences>(), sl<UserRepository>()));

  sl.registerLazySingleton<DrawerCubit>(() => DrawerCubit(sl<BlackoutPreferences>(), sl<HomeRepository>()));

  sl.registerLazySingleton<BatchCubit>(() => BatchCubit(sl<ChangeRepository>(), sl<BatchRepository>(), sl<BlackoutPreferences>()));
  sl.registerLazySingleton<ProductCubit>(() => ProductCubit(sl<GroupRepository>(), sl<BlackoutPreferences>(), sl<ProductRepository>()));
  sl.registerLazySingleton<GroupCubit>(() => GroupCubit(sl<GroupRepository>(), sl<BlackoutPreferences>()));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl<BlackoutPreferences>(), sl<GroupRepository>(), sl<ProductRepository>()));
  sl.registerLazySingleton<SpeedDialCubit>(() => SpeedDialCubit(sl<ProductRepository>(), sl<BlackoutPreferences>(), sl<ChangeRepository>(), sl<GroupRepository>()));
}
