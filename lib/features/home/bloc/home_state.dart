part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class Loading extends HomeState {}

class LoadedAll extends HomeState {
  final List<HomeListable> cards;

  LoadedAll(this.cards);
}

class GoToProduct extends HomeState {}

class GoToGroup extends HomeState {}
