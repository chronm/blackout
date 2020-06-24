import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/home_repository.dart';
import '../../../main.dart';
import '../../../models/home.dart';
import '../../settings/bloc/settings_bloc.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final BlackoutPreferences blackoutPreferences;
  final HomeRepository homeRepository;

  DrawerBloc(this.blackoutPreferences, this.homeRepository);

  @override
  DrawerState get initialState => InitialDrawerState();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is InitializeDrawer) {
      var user = await blackoutPreferences.getUser();
      var home = await blackoutPreferences.getHome();
      var other = await homeRepository.findAll();
      if (user != null && home != null) {
        yield LoadedDrawer(user.name, other, other.indexOf(home));
      }
    }
    if (event is TapOnSettings) {
      sl<SettingsBloc>().add(InitializeSettings());
      yield GoToSettings();
    }
  }
}
