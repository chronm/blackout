import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/widget/changes_widget/changes_widget.dart';
import 'package:Blackout/widget/charge_configuration/charge_configuration.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
      Charge charge = Charge(product: event.product);
      yield ShowCharge(charge);
    }
    if (event is SaveChargeAndClose) {
      User user = await blackoutPreferences.getUser();
      Charge charge = await chargeRepository.save(event.charge, user);
      Navigator.pop(event.context, charge);
      yield ShowCharge(charge);
    }
    if (event is LoadCharge) {
      Charge charge = await chargeRepository.findOneByChargeId(event.chargeId);
      yield ShowCharge(charge);
    }
    if (event is TapOnShowChargeConfiguration) {
      showDialog(
        context: event.context,
        builder: (context) => ChargeConfiguration(
          charge: event.charge,
          action: (charge) => this.add(SaveChargeAndClose(charge, context)),
        ),
      );
    }
    if (event is TapOnShowChargeChanges) {
      showDialog(
        context: event.context,
        builder: (context) => ChangesWidget(changes: event.changes),
      );
    }
  }
}
