part of 'blackout_bloc.dart';

abstract class BlackoutState {}

class InitialMainState extends BlackoutState {}

class AskForImportDatabase extends BlackoutState {}

class AskForStorageRationale extends BlackoutState {}

class AskForRedirectToSettings extends BlackoutState {}

class GoToSetup extends BlackoutState {}

class GoToHome extends BlackoutState {}

class ShowChangelog extends BlackoutState {}
