part of 'drawer_bloc.dart';

abstract class DrawerEvent {}

class TapOnSettings extends DrawerEvent {
  final BuildContext context;

  TapOnSettings(this.context);
}

class InitializeDrawer extends DrawerEvent {}
