import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:uuid/uuid.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final SharedPreferenceCache _sharedPreferenceCache;
  final HomeBloc _homeBloc;
  final HomeRepository homeRepository;
  final UserRepository userRepository;

  SetupBloc(this._sharedPreferenceCache, this._homeBloc, this.homeRepository, this.userRepository);

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is SetupAndCreateEvent) {
      Home home = Home(id: Uuid().v4(), name: event.home);
      homeRepository.save(home);

      User user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user);
      _sharedPreferenceCache.setUser(user);
    }
    if (event is SetupAndJoinEvent) {
      User user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user);
      _sharedPreferenceCache.setUser(user);
    }
  }
}
