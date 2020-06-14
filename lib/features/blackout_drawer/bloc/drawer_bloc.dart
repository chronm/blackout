import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/features/settings/bloc/settings_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator;

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
      User user = await blackoutPreferences.getUser();
      Home home = await blackoutPreferences.getHome();
      List<Home> other = await homeRepository.findAll();
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
