part of 'charge_bloc.dart';

abstract class ChargeEvent extends Equatable {}

class CreateCharge extends ChargeEvent {
  @override
  List<Object> get props => [];
}

class LoadCharge extends ChargeEvent {
  final String chargeId;

  LoadCharge(this.chargeId);

  @override
  List<Object> get props => [chargeId];
}

class SaveCharge extends ChargeEvent {
  final Charge charge;

  SaveCharge(this.charge);

  @override
  List<Object> get props => [charge];
}
