import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/user_repository.dart';
import '../../../models/user.dart';
import '../settings_screen.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final BlackoutPreferences blackoutPreferences;
  final UserRepository userRepository;

  SettingsBloc(this.blackoutPreferences, this.userRepository);

  @override
  SettingsState get initialState => InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is InitializeSettings) {
      var user = await blackoutPreferences.getUser();
      yield LoadedSettings(user);
    }
    if (event is SaveSettings) {
      await blackoutPreferences.setUser(event.settings.user);
      await userRepository.save(event.settings.user, active: false);
      yield GoBack();
    }
  }
}
