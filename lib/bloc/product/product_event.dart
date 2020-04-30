part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class LoadProduct extends ProductEvent {
  final Product product;

  LoadProduct(this.product);

  @override
  List<Object> get props => [product];
}
