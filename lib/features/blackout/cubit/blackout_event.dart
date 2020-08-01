part of 'blackout_cubit.dart';

abstract class BlackoutEvent {}

class InitializeApp extends BlackoutEvent {}

class ImportDatabase extends BlackoutEvent {
  final String password;

  ImportDatabase(this.password);
}

class DropDatabaseAndSetup extends BlackoutEvent {}

class CheckPermissions extends BlackoutEvent {}

class EndApp extends BlackoutEvent {}
