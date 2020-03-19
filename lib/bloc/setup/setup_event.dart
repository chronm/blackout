part of 'setup_bloc.dart';

abstract class SetupEvent extends Equatable {}

class SetupAndCreateEvent extends SetupEvent {
  final String username;
  final String home;

  SetupAndCreateEvent(this.username, this.home);

  @override
  List<Object> get props => [username, home];
}

class SetupAndJoinEvent extends SetupEvent {
  final String username;
  final Home home;

  SetupAndJoinEvent(this.username, this.home);

  @override
  List<Object> get props => [username, home];
}
