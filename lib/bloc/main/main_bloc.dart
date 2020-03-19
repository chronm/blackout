import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final SharedPreferenceCache _sharedPreferenceCache;
  final HomeBloc _homeBloc;

  MainBloc(this._sharedPreferenceCache, this._homeBloc);

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) {
    throw UnimplementedError();
  }
}
