part of 'home_bloc.dart';

abstract class HomeEvent {}

class Redraw extends HomeEvent {}

class UseCards extends HomeEvent {
  final List<HomeListable> cards;

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
