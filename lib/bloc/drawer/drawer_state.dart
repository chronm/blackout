part of 'drawer_bloc.dart';

abstract class DrawerState {}

class InitialDrawerState extends DrawerState {}

class LoadedDrawer extends DrawerState {
  final String username;
  final List<Home> homes;
  final int activeHome;

  LoadedDrawer(this.username, this.homes, this.activeHome);
}
