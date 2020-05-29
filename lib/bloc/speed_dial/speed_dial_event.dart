part of 'speed_dial_bloc.dart';

abstract class SpeedDialEvent{}

class ScannedEan extends SpeedDialEvent {
  final String ean;
  final BuildContext context;

  ScannedEan(this.ean, this.context);
}

class TapOnAddToCharge extends SpeedDialEvent {
  final Charge charge;
  final BuildContext context;

  TapOnAddToCharge(this.context, this.charge);
}

class TapOnTakeFromCharge extends SpeedDialEvent {
  final Charge charge;
  final BuildContext context;

  TapOnTakeFromCharge(this.context, this.charge);
}

class TapOnCreateCharge extends SpeedDialEvent {
  final BuildContext context;
  final Product product;

  TapOnCreateCharge(this.context, this.product);
}

class TapOnCreateProduct extends SpeedDialEvent {
  final BuildContext context;
  final Group group;

  TapOnCreateProduct(this.context, this.group);
}

class TapOnCreateGroup extends SpeedDialEvent {
  final BuildContext context;

  TapOnCreateGroup(this.context);
}

class TapOnGotoHome extends SpeedDialEvent {
  final BuildContext context;

  TapOnGotoHome(this.context);
}
