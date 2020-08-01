import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/user_repository.dart';
import '../../../models/user.dart';
import '../settings_screen.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final BlackoutPreferences blackoutPreferences;
  final UserRepository userRepository;

  SettingsCubit(this.blackoutPreferences, this.userRepository) : super(InitialSettingsState());

  void initializeSettings() async {
    var user = await blackoutPreferences.getUser();
    emit(LoadedSettings(user));
  }

  void saveSettings(Settings settings) async {
    await blackoutPreferences.setUser(settings.user);
    await userRepository.save(settings.user, active: false);
    emit(GoBack());
  }
}
