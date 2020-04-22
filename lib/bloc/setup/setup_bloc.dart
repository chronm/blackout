import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:uuid/uuid.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final BlackoutPreferences _blackoutPreferences;
  final HomeBloc _homeBloc;
  final HomeRepository homeRepository;
  final UserRepository userRepository;

  SetupBloc(this._blackoutPreferences, this._homeBloc, this.homeRepository, this.userRepository);

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is SetupAndCreateEvent) {
      Home home = Home(id: Uuid().v4(), name: event.home);
      home = await homeRepository.save(home);

      User user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user);
      await _blackoutPreferences.setUser(user);
      await _blackoutPreferences.setHome(home);
      _homeBloc.add(LoadAll());
      yield GoToHome();
    }
    if (event is SetupAndJoinEvent) {
      throw UnimplementedError();
    }
  }
}
