part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct(this.productId);
}

class SaveProduct extends ProductEvent {
  final Product product;

  SaveProduct(this.product);
}

class TapOnBatch extends ProductEvent {
  final Batch batch;

  TapOnBatch(this.batch);
}

class TapOnDeleteProduct extends ProductEvent {
  final Product product;

  TapOnDeleteProduct(this.product);
}
