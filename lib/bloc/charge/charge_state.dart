part of 'charge_bloc.dart';

abstract class ChargeState extends Equatable {}

class InitialChargeState extends ChargeState {
  @override
  List<Object> get props => [];
}

class ShowCharge extends ChargeState {
  final Charge charge;

  ShowCharge(this.charge);

  @override
  List<Object> get props => [charge];
}
