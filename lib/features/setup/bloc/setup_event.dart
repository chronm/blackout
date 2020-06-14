part of 'setup_bloc.dart';

abstract class SetupEvent {}

class CreateHomeAndFinish extends SetupEvent {
  final String username;
  final String home;

  CreateHomeAndFinish(this.username, this.home);
}

class JoinHomeAndFinish extends SetupEvent {
  final String username;
  final Home home;

  JoinHomeAndFinish(this.username, this.home);
}
