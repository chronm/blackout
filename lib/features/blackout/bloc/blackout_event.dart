part of 'blackout_bloc.dart';

abstract class BlackoutEvent {}

class InitializeApp extends BlackoutEvent {}

class ImportDatabase extends BlackoutEvent {}

class DropDatabaseAndSetup extends BlackoutEvent {}

class CheckPermissions extends BlackoutEvent {}

class EndApp extends BlackoutEvent {}
