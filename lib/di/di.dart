import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/features/blackout_drawer/bloc/drawer_bloc.dart';
import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/features/group/bloc/group_bloc.dart';
import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:Blackout/features/blackout/bloc/blackout_bloc.dart';
import 'package:Blackout/features/settings/bloc/settings_bloc.dart';
import 'package:Blackout/features/setup/bloc/setup_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

Database database;
bool main = true;
bool import = true;
bool application = true;

void prepareMain() async {
  if (main) {
    sl.registerSingleton<BlackoutPreferences>(BlackoutPreferences(await SharedPreferences.getInstance()));
    sl.registerSingleton<BlackoutBloc>(BlackoutBloc(sl<BlackoutPreferences>()));
    main = false;
  }
}

void prepareImport() async {
  if (import) {
    database = Database();
    sl.registerSingleton<HomeRepository>(database.homeRepository);
    sl.registerSingleton<UserRepository>(database.userRepository);
    import = false;
  }
}

void prepareApplication() async {
  if (application) {
    await prepareMain();
    await prepareImport();
    await registerDatabase();
    await registerBloc();
    sl.registerSingleton<SetupBloc>(SetupBloc(sl<BlackoutPreferences>(), sl<HomeBloc>(), sl<HomeRepository>(), sl<UserRepository>(), sl<GroupRepository>(), sl<ProductRepository>(), sl<ChargeRepository>(), sl<ChangeRepository>(), sl<DrawerBloc>()));
    application = true;
  }
}

void registerDatabase() async {
  sl.registerSingleton<GroupRepository>(database.groupRepository);
  sl.registerSingleton<ChangeRepository>(database.changeRepository);
  sl.registerSingleton<ChargeRepository>(database.chargeRepository);
  sl.registerSingleton<ProductRepository>(database.productRepository);
  sl.registerSingleton<SyncRepository>(database.syncRepository);
}

void registerBloc() async {
  sl.registerSingleton<SettingsBloc>(SettingsBloc(sl<BlackoutPreferences>(), sl<UserRepository>()));

  sl.registerSingleton<DrawerBloc>(DrawerBloc(sl<BlackoutPreferences>(), sl<HomeRepository>()));

  sl.registerSingleton<ChargeBloc>(ChargeBloc(sl<ChangeRepository>(), sl<ChargeRepository>(), sl<BlackoutPreferences>()));
  sl.registerSingleton<ProductBloc>(ProductBloc(sl<GroupRepository>(), sl<BlackoutPreferences>(), sl<ProductRepository>()));
  sl.registerSingleton<GroupBloc>(GroupBloc(sl<GroupRepository>(), sl<BlackoutPreferences>()));
  sl.registerSingleton<HomeBloc>(HomeBloc(sl<BlackoutPreferences>(), sl<GroupRepository>(), sl<ProductRepository>()));
  sl.registerSingleton<SpeedDialBloc>(SpeedDialBloc(sl<ProductRepository>(), sl<BlackoutPreferences>(), sl<ChangeRepository>(), sl<GroupRepository>()));
}
