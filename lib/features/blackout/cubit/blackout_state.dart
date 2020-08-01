part of 'blackout_cubit.dart';

abstract class BlackoutState {}

class InitialMainState extends BlackoutState {}

class AskForImportDatabase extends BlackoutState {
  final bool wrongPassword;

  AskForImportDatabase({this.wrongPassword = false});
}

class AskForStorageRationale extends BlackoutState {}

class AskForRedirectToSettings extends BlackoutState {}

class GoToSetup extends BlackoutState {}

class GoToHome extends BlackoutState {}
