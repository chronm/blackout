import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/change_repository.dart';
import '../../../data/repository/charge_repository.dart';
import '../../../models/charge.dart';
import '../../../models/product.dart';

part 'charge_event.dart';
part 'charge_state.dart';

class ChargeBloc extends Bloc<ChargeEvent, ChargeState> {
  final ChangeRepository changeRepository;
  final ChargeRepository chargeRepository;
  final BlackoutPreferences blackoutPreferences;

  ChargeBloc(this.changeRepository, this.chargeRepository, this.blackoutPreferences);

  @override
  ChargeState get initialState => InitialChargeState();

  @override
  Stream<ChargeState> mapEventToState(ChargeEvent event) async* {
    if (event is CreateCharge) {
      var charge = Charge(product: event.product);
      yield ShowCharge(charge);
    }
    if (event is SaveCharge) {
      var user = await blackoutPreferences.getUser();
      var charge = await chargeRepository.save(event.charge, user);
      yield ShowCharge(charge);
    }
    if (event is LoadCharge) {
      var charge = await chargeRepository.findOneByChargeId(event.chargeId);
      yield ShowCharge(charge);
    }
  }
}
