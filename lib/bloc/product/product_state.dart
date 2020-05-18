part of 'product_bloc.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ShowProduct extends ProductState {
  final Product product;
  final List<Category> categories;

  ShowProduct(this.product, this.categories);

  @override
  List<Object> get props => [product, categories];
}
