part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class SaveProduct extends ProductEvent {
  final Product product;

  SaveProduct(this.product);

  @override
  List<Object> get props => [product];
}
