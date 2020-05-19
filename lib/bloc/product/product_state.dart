part of 'product_bloc.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ShowProduct extends ProductState {
  final Product product;
  final List<Group> groups;

  ShowProduct(this.product, this.groups);

  @override
  List<Object> get props => [product, groups];
}
