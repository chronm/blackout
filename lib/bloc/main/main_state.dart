part of 'main_bloc.dart';

abstract class MainState {}

class InitialMainState extends MainState {}

class GoToSetup extends MainState {}

class GoToHome extends MainState {}

class ShowChangelog extends MainState {}

class LoadingState {}
