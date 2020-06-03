part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadAll extends HomeEvent {}

class TapOnGroup extends HomeEvent {
  final Group group;
  final BuildContext context;

  TapOnGroup(this.group, this.context);
}

class TapOnProduct extends HomeEvent {
  final Product product;
  final BuildContext context;

  TapOnProduct(this.product, this.context);
}
