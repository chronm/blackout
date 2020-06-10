import 'dart:async';

import 'package:Blackout/bloc/settings/settings_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator;

part 'drawer_event.dart';

part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  final BlackoutPreferences blackoutPreferences;

  DrawerBloc(this.blackoutPreferences);

  @override
  DrawerState get initialState => InitialDrawerState();

  @override
  Stream<DrawerState> mapEventToState(DrawerEvent event) async* {
    if (event is InitializeDrawer) {
      User user = await blackoutPreferences.getUser();
      Home home = await blackoutPreferences.getHome();
      if (user != null && home != null) {
        yield LoadedDrawer(user.name, home.name);
      }
    }
    if (event is TapOnSettings) {
      Navigator.pop(event.context);
      Navigator.push(event.context, RouteBuilder.build(Routes.SettingsRoute));
      sl<SettingsBloc>().add(InitializeSettings());
    }
  }
}
