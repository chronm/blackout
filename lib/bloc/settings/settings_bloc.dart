import 'dart:async';

import 'package:Blackout/bloc/drawer/drawer_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/ui/settings/settings_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
      User user = await blackoutPreferences.getUser();
      yield LoadedSettings(user);
    }
    if (event is SaveSettings) {
      await blackoutPreferences.setUser(event.settings.user);
      await userRepository.save(event.settings.user, other: false);
      Navigator.pop(event.context);
      sl<DrawerBloc>().add(InitializeDrawer());
    }
  }
}
