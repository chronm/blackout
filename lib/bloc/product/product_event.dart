part of 'product_bloc.dart';

abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final String productId;

  LoadProduct(this.productId);
}

class SaveProductAndClose extends ProductEvent {
  final Product product;
  final BuildContext context;

  SaveProductAndClose(this.product, this.context);
}

class TapOnCharge extends ProductEvent {
  final Charge charge;

  TapOnCharge(this.charge);
}

class TapOnShowProductConfiguration extends ProductEvent {
  final Product product;
  final List<Group> groups;
  final BuildContext context;

  TapOnShowProductConfiguration(this.product, this.groups, this.context);
}

class TapOnShowProductChanges extends ProductEvent {
  final List<ModelChange> changes;
  final BuildContext context;

  TapOnShowProductChanges(this.changes, this.context);
}
