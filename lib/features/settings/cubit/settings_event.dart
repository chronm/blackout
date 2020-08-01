part of 'settings_cubit.dart';

abstract class SettingsEvent {}

class InitializeSettings extends SettingsEvent {}

class SaveSettings extends SettingsEvent {
  final Settings settings;

  SaveSettings(this.settings);
}
