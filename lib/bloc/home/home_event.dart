part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class LoadAll extends HomeEvent {
  @override
  List<Object> get props => [];
}

class TapOnGroup extends HomeEvent {
  final Group group;
  final BuildContext context;

  TapOnGroup(this.group, this.context);

  @override
  List<Object> get props => [group, context];
}

class TapOnProduct extends HomeEvent {
  final Product product;
  final BuildContext context;

  TapOnProduct(this.product, this.context);

  @override
  List<Object> get props => [product, context];
}
