import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/home_repository.dart';
import '../../../main.dart';
import '../../../models/home.dart';
import '../../settings/cubit/settings_cubit.dart';

part 'drawer_event.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  final BlackoutPreferences blackoutPreferences;
  final HomeRepository homeRepository;

  DrawerCubit(this.blackoutPreferences, this.homeRepository) : super(InitialDrawerState());

  void initializeDrawer() async {
    var user = await blackoutPreferences.getUser();
    var home = await blackoutPreferences.getHome();
    var other = await homeRepository.findAll();
    if (user != null && home != null) {
      emit(LoadedDrawer(user.name, other, other.indexOf(home)));
    }
  }

  void tapOnSettings() async {
    sl<SettingsCubit>().initializeSettings();
    emit(GoToSettings());
  }
}
