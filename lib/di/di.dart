import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart' show MainBloc;
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart' show SharedPreferenceCache;
import 'package:get_it/get_it.dart' show GetIt;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

Future<SharedPreferenceCache> createSharedPreferenceCache() async => SharedPreferenceCache(SharedPreferences.getInstance());

void prepareSharedPreferences(GetIt sl) async {
  sl.registerSingleton<SharedPreferenceCache>(await createSharedPreferenceCache());
}

void prepareBlocs(GetIt sl) async {
  sl.registerSingleton<HomeBloc>(HomeBloc());
  sl.registerSingleton<MainBloc>(MainBloc(sl<SharedPreferenceCache>(), sl<HomeBloc>()));
}

void prepareDi() async {
  GetIt sl = GetIt.instance;

  await prepareSharedPreferences(sl);
  await prepareBlocs(sl);
}
