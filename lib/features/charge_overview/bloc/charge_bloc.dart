import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart';

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
      Charge charge = Charge(product: event.product);
      yield ShowCharge(charge);
    }
    if (event is SaveCharge) {
      User user = await blackoutPreferences.getUser();
      Charge charge = await chargeRepository.save(event.charge, user);
      yield ShowCharge(charge);
    }
    if (event is LoadCharge) {
      Charge charge = await chargeRepository.findOneByChargeId(event.chargeId);
      yield ShowCharge(charge);
    }
  }
}
