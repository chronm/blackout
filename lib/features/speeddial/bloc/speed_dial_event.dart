part of 'speed_dial_bloc.dart';

abstract class SpeedDialEvent {}

class TapOnScanEan extends SpeedDialEvent {}

class TapOnCreateBatch extends SpeedDialEvent {
  final Product product;

  TapOnCreateBatch(this.product);
}

class TapOnCreateProduct extends SpeedDialEvent {}

class TapOnCreateProductInGroup extends SpeedDialEvent {
  final Group group;

  TapOnCreateProductInGroup(this.group);
}

class TapOnCreateGroup extends SpeedDialEvent {}

class TapOnCreateGroupForProduct extends SpeedDialEvent {}

class TapOnGotoHome extends SpeedDialEvent {}

class AddToBatch extends SpeedDialEvent {
  final Batch batch;
  final String amount;

  AddToBatch(this.batch, this.amount);
}

class TakeFromBatch extends SpeedDialEvent {
  final Batch batch;
  final String amount;

  TakeFromBatch(this.batch, this.amount);
}
