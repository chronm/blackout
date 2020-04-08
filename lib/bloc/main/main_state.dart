part of 'main_bloc.dart';

abstract class MainState extends Equatable {}

class InitialMainState extends MainState {
  @override
  List<Object> get props => [];
}

class GoToSetup extends MainState {
  @override
  List<Object> get props => [];
}

class GoToHome extends MainState {
  @override
  List<Object> get props => [];
}

class LoadingState {}
