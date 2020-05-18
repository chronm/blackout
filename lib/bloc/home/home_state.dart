part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class Loading extends HomeState implements LoadingState {
  @override
  List<Object> get props => [];
}

class LoadedAll extends HomeState {
  final List<HomeListable> cards;

  LoadedAll(this.cards);

  @override
  List<Object> get props => [cards];
}
