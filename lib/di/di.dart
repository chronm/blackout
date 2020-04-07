import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart' show MainBloc;
import 'package:Blackout/bloc/setup/setup_bloc.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/database_changelog_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart' show SharedPreferenceCache;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

Future<SharedPreferenceCache> createSharedPreferenceCache() async => SharedPreferenceCache(SharedPreferences.getInstance());

void prepareSharedPreferences(GetIt sl) async {
  sl.registerSingleton<SharedPreferenceCache>(await createSharedPreferenceCache());
}

void prepareBlocs(GetIt sl) async {
  sl.registerSingleton<HomeBloc>(HomeBloc(sl<SharedPreferenceCache>(), sl<CategoryRepository>(), sl<ProductRepository>()));
  sl.registerSingleton<SetupBloc>(SetupBloc(sl<SharedPreferenceCache>(), sl<HomeBloc>(), sl<HomeRepository>(), sl<UserRepository>()));
  sl.registerSingleton<MainBloc>(MainBloc(sl<SharedPreferenceCache>(), sl<HomeBloc>()));
}

void registerRepositories(GetIt sl) async {
  Database database = Database();
  sl.registerSingleton<HomeRepository>(database.homeRepository);
  sl.registerSingleton<CategoryRepository>(database.categoryRepository);
  sl.registerSingleton<ChangeRepository>(database.changeRepository);
  sl.registerSingleton<DatabaseChangelogRepository>(database.databaseChangelogRepository);
  sl.registerSingleton<ItemRepository>(database.itemRepository);
  sl.registerSingleton<ProductRepository>(database.productRepository);
  sl.registerSingleton<SyncRepository>(database.syncRepository);
  sl.registerSingleton<UserRepository>(database.userRepository);
}

void prepareDi() async {
  GetIt sl = GetIt.instance;

  await prepareSharedPreferences(sl);
  await registerRepositories(sl);
  await prepareBlocs(sl);
}
