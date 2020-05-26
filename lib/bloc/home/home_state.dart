part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitialState extends HomeState {}

class Loading extends HomeState implements LoadingState {}

class LoadedAll extends HomeState {
  final List<HomeListable> cards;

  LoadedAll(this.cards);
}
