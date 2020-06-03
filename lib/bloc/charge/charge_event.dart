part of 'charge_bloc.dart';

abstract class ChargeEvent {}

class CreateCharge extends ChargeEvent {
  final Product product;

  CreateCharge(this.product);
}

class LoadCharge extends ChargeEvent {
  final String chargeId;

  LoadCharge(this.chargeId);
}

class SaveChargeAndClose extends ChargeEvent {
  final Charge charge;
  final BuildContext context;

  SaveChargeAndClose(this.charge, this.context);
}

class TapOnShowChargeConfiguration extends ChargeEvent {
  final Charge charge;
  final BuildContext context;

  TapOnShowChargeConfiguration(this.charge, this.context);
}

class TapOnShowChargeChanges extends ChargeEvent {
  final List<ModelChange> changes;
  final BuildContext context;

  TapOnShowChargeChanges(this.changes, this.context);
}
