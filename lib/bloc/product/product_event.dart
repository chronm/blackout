part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class CreateProduct extends ProductEvent {
  final String ean;
  final Group group;

  CreateProduct(this.ean, this.group);

  @override
  List<Object> get props => [ean, group];
}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct(this.productId);

  @override
  List<Object> get props => [productId];
}

class SaveProductAndReturn extends ProductEvent {
  final Product product;
  final BuildContext context;

  SaveProductAndReturn(this.product, this.context);

  @override
  List<Object> get props => [product, context];
}

class TapOnCharge extends ProductEvent {
  final Charge charge;

  TapOnCharge(this.charge);

  @override
  List<Object> get props => [charge];
}
