part of 'product_bloc.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object> get props => [];
}

class ShowProduct extends ProductState {
  final Product product;
  final List<ModelChange> changes;

  ShowProduct(this.product, this.changes);

  @override
  List<Object> get props => [product, changes];
}
