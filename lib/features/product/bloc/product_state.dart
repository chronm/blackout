part of 'product_bloc.dart';

abstract class ProductState {}

class ProductInitialState extends ProductState {}

class ShowProduct extends ProductState {
  final Product product;
  final List<Group> groups;

  ShowProduct(this.product, this.groups);
}

class GoToBatch extends ProductState {
  final String currentProduct;

  GoToBatch(this.currentProduct);
}

class GoBack extends ProductState {}
