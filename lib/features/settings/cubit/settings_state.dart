part of 'settings_cubit.dart';

abstract class SettingsState {}

class InitialSettingsState extends SettingsState {}

class LoadedSettings extends SettingsState {
  final User user;

  LoadedSettings(this.user);
}

class GoBack extends SettingsState {}
