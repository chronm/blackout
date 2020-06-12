part of 'main_bloc.dart';

abstract class MainEvent {}

class InitializeAppEvent extends MainEvent {
  final BuildContext context;

  InitializeAppEvent(this.context);
}
