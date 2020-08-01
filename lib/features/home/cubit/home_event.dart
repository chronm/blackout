part of 'home_cubit.dart';

abstract class HomeEvent {}

class RoutineCheck extends HomeEvent {}

class DoUpdate extends HomeEvent {}

class Redraw extends HomeEvent {}

class UseCards extends HomeEvent {
  final List<HomeCard> cards;

  UseCards(this.cards);
}

class LoadAll extends HomeEvent {}

class TapOnGroup extends HomeEvent {
  final Group group;

  TapOnGroup(this.group);
}

class TapOnProduct extends HomeEvent {
  final Product product;

  TapOnProduct(this.product);
}
