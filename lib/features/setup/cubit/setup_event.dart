part of 'setup_cubit.dart';

abstract class SetupEvent {}

class CreateHomeAndFinish extends SetupEvent {
  final String username;
  final String home;
  final String password;

  CreateHomeAndFinish(this.username, this.home, this.password);
}

class JoinHomeAndFinish extends SetupEvent {
  final String username;
  final Home home;

  JoinHomeAndFinish(this.username, this.home);
}
