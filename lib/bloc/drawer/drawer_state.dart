part of 'drawer_bloc.dart';

abstract class DrawerState {}

class InitialDrawerState extends DrawerState {}

class LoadedDrawer extends DrawerState {
  final String username;
  final String homeName;

  LoadedDrawer(this.username, this.homeName);
}
