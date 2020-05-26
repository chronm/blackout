part of 'charge_bloc.dart';

abstract class ChargeState {}

class InitialChargeState extends ChargeState {}

class ShowCharge extends ChargeState {
  final Charge charge;

  ShowCharge(this.charge);
}
