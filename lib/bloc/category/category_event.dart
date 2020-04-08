part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class LoadCategory extends CategoryEvent {
  final Category category;

  LoadCategory(this.category);

  @override
  List<Object> get props => [category];
}
