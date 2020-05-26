import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'charge_event.dart';

part 'charge_state.dart';

class ChargeBloc extends Bloc<ChargeEvent, ChargeState> {
  final ModelChangeRepository modelChangeRepository;
  final ChangeRepository changeRepository;
  final ChargeRepository chargeRepository;
  final BlackoutPreferences blackoutPreferences;

  ChargeBloc(this.changeRepository, this.chargeRepository, this.blackoutPreferences, this.modelChangeRepository);

  @override
  ChargeState get initialState => InitialChargeState();

  @override
  Stream<ChargeState> mapEventToState(ChargeEvent event) async* {
    if (event is CreateCharge) {
      Home home = await blackoutPreferences.getHome();
      Charge charge = Charge(home: home);
      yield ShowCharge(charge);
    }
    if (event is SaveCharge) {
      User user = await blackoutPreferences.getUser();
      Charge charge = await chargeRepository.save(event.charge, user);
      yield ShowCharge(charge);
    }
    if (event is LoadCharge) {
      Home home = await blackoutPreferences.getHome();
      Charge charge = await chargeRepository.getOneByChargeIdAndHomeId(event.chargeId, home.id);
      yield ShowCharge(charge);
    }
  }
}
