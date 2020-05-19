part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class LoadAll extends HomeEvent {
  @override
  List<Object> get props => [];
}

class TapOnGroup extends HomeEvent {
  final Group group;

  TapOnGroup(this.group);

  @override
  List<Object> get props => [group];
}

class TapOnProduct extends HomeEvent {
  final Product product;

  TapOnProduct(this.product);

  @override
  List<Object> get props => [product];
}
