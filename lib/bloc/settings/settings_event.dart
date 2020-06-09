part of 'settings_bloc.dart';

abstract class SettingsEvent {}

class InitializeSettings extends SettingsEvent {}

class SaveSettings extends SettingsEvent {
  final Settings settings;
  final BuildContext context;

  SaveSettings(this.settings, this.context);
}
