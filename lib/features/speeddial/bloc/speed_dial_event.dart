part of 'speed_dial_bloc.dart';

abstract class SpeedDialEvent{}

class TapOnScanEan extends SpeedDialEvent {}

class TapOnCreateCharge extends SpeedDialEvent {
  final Product product;

  TapOnCreateCharge(this.product);
}

class TapOnCreateProduct extends SpeedDialEvent {}

class TapOnCreateProductInGroup extends SpeedDialEvent {
  final Group group;

  TapOnCreateProductInGroup(this.group);
}

class TapOnCreateGroup extends SpeedDialEvent {}

class TapOnCreateGroupForProduct extends SpeedDialEvent {}

class TapOnGotoHome extends SpeedDialEvent {}

class AddToCharge extends SpeedDialEvent {
  final Charge charge;
  final String amount;

  AddToCharge(this.charge, this.amount);
}

class TakeFromCharge extends SpeedDialEvent {
  final Charge charge;
  final String amount;

  TakeFromCharge(this.charge, this.amount);
}