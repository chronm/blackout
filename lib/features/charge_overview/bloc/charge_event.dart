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

class SaveCharge extends ChargeEvent {
  final Charge charge;

  SaveCharge(this.charge);
}
