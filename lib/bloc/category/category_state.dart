part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class InitialCategoryState extends CategoryState {
  @override
  List<Object> get props => [];
}

class ShowCategory extends CategoryState {
  final Category category;

  ShowCategory(this.category);

  @override
  List<Object> get props => [category];
}

class Loading extends CategoryState implements LoadingState {
  @override
  List<Object> get props => [];
}
