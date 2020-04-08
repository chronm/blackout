part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class LoadAll extends HomeEvent {
  @override
  List<Object> get props => [];
}

class TapOnCategory extends HomeEvent {
  final Category category;

  TapOnCategory(this.category);

  @override
  List<Object> get props => [category];
}
