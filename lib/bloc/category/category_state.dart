part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class InitialCategoryState extends CategoryState {
  @override
  List<Object> get props => [];
}

class ShowCategory extends CategoryState {
  final Category category;
  final List<ModelChange> changes;

  ShowCategory(this.category, this.changes);

  @override
  List<Object> get props => [category, changes];
}

class Loading extends CategoryState implements LoadingState {
  @override
  List<Object> get props => [];
}
