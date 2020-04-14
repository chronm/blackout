part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class LoadCategory extends CategoryEvent {
  final Category category;

  LoadCategory(this.category);

  @override
  List<Object> get props => [category];
}

class TapOnCategoryDetails extends CategoryEvent {
  final Category category;

  TapOnCategoryDetails(this.category);

  @override
  List<Object> get props => [category];
}

class SaveCategory extends CategoryEvent {
  final Category category;

  SaveCategory(this.category);

  @override
  List<Object> get props => [category];
}
