part of 'settings_bloc.dart';

abstract class SettingsState {}

class InitialSettingsState extends SettingsState {}

class LoadedSettings extends SettingsState {
  final User user;

  LoadedSettings(this.user);
}
