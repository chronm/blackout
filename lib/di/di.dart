import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart' show MainBloc;
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/bloc/setup/setup_bloc.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

Future<BlackoutPreferences> createBlackoutPreferences() async => BlackoutPreferences(await SharedPreferences.getInstance());

void prepareSharedPreferences(GetIt sl) async {
  sl.registerSingleton<BlackoutPreferences>(await createBlackoutPreferences());
}

void prepareBlocs(GetIt sl) async {
  sl.registerSingleton<ChargeBloc>(ChargeBloc(sl<ChangeRepository>(), sl<ChargeRepository>(), sl<BlackoutPreferences>(), sl<ModelChangeRepository>()));
  sl.registerSingleton<ProductBloc>(ProductBloc(sl<ModelChangeRepository>(), sl<CategoryRepository>(), sl<BlackoutPreferences>(), sl<ProductRepository>(), sl<ChargeBloc>()));
  sl.registerSingleton<CategoryBloc>(CategoryBloc(sl<CategoryRepository>(), sl<ModelChangeRepository>(), sl<BlackoutPreferences>(), sl<ProductBloc>()));
  sl.registerSingleton<HomeBloc>(HomeBloc(sl<BlackoutPreferences>(), sl<CategoryRepository>(), sl<ProductRepository>(), sl<CategoryBloc>(),sl<ModelChangeRepository>(), sl<ProductBloc>()));
  sl.registerSingleton<SetupBloc>(SetupBloc(sl<BlackoutPreferences>(), sl<HomeBloc>(), sl<HomeRepository>(), sl<UserRepository>(), sl<CategoryRepository>(), sl<ProductRepository>(), sl<ChargeRepository>(), sl<ChangeRepository>()));
  sl.registerSingleton<MainBloc>(MainBloc(sl<BlackoutPreferences>(), sl<HomeBloc>()));
}

void registerRepositories(GetIt sl) async {
  Database database = Database();
  sl.registerSingleton<HomeRepository>(database.homeRepository);
  sl.registerSingleton<CategoryRepository>(database.categoryRepository);
  sl.registerSingleton<ChangeRepository>(database.changeRepository);
  sl.registerSingleton<ModelChangeRepository>(database.modelChangeRepository);
  sl.registerSingleton<ChargeRepository>(database.chargeRepository);
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
