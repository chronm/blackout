import 'dart:async';

import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show AlertDialog, BuildContext, FlatButton, Navigator, Text, TextEditingController, TextField, showDialog;
import 'package:time_machine/time_machine.dart';

part 'speed_dial_event.dart';

part 'speed_dial_state.dart';

class SpeedDialBloc extends Bloc<SpeedDialEvent, SpeedDialState> {
  final BlackoutPreferences blackoutPreferences;
  final ChangeRepository changeRepository;
  final ProductRepository productRepository;
  final HomeBloc homeBloc;
  final ChargeBloc chargeBloc;
  final ProductBloc productBloc;
  final GroupBloc groupBloc;

  SpeedDialBloc(this.productRepository, this.blackoutPreferences, this.productBloc, this.homeBloc, this.groupBloc, this.chargeBloc, this.changeRepository);

  @override
  SpeedDialState get initialState => InitialSpeedDialState();

  @override
  Stream<SpeedDialState> mapEventToState(SpeedDialEvent event) async* {
    if (event is ScannedEan) {
      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.getOneByEanAndHomeId(event.ean, home.id);
      if (product != null) {
        productBloc.add(LoadProduct(product.id));
        Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
      } else {
        productBloc.add(CreateProduct(event.ean));
        Navigator.push(event.context, RouteBuilder.build(Routes.ProductDetailsRoute));
      }
    }
    if (event is TapOnCreateCharge) {
      chargeBloc.add(CreateCharge());
      Navigator.push(event.context, RouteBuilder.build(Routes.ChargeDetailsRoute));
    }
    if (event is TapOnCreateProduct) {
      productBloc.add(CreateProduct(""));
      Navigator.push(event.context, RouteBuilder.build(Routes.ProductDetailsRoute));
    }
    if (event is TapOnCreateGroup) {
      groupBloc.add(CreateGroup());
      Navigator.push(event.context, RouteBuilder.build(Routes.GroupDetailsRoute));
    }
    if (event is TapOnGotoHome) {
      sl<HomeBloc>().add(LoadAll());
      Navigator.popUntil(event.context, (route) => route.isFirst);
    }
    if (event is TapOnAddToCharge) {
      Charge charge = event.charge;
      TextEditingController controller = TextEditingController();
      Home home = await blackoutPreferences.getHome();
      User user = await blackoutPreferences.getUser();
      Amount amount;
      await showDialog(
        context: event.context,
        child: AlertDialog(
          content: TextField(
            autofocus: true,
            controller: controller,
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(event.context),
            ),
            FlatButton(
              child: Text("Accept"),
              onPressed: () async {
                amount = Amount.fromInput(controller.text, charge.product.unit);
                Change change = Change(
                  changeDate: LocalDateTime.now(),
                  home: home,
                  user: user,
                  charge: charge,
                  value: UnitConverter.toSi(amount).value,
                );
                await changeRepository.save(change);
                chargeBloc.add(LoadCharge(charge.id));
                Navigator.pop(event.context);
              },
            )
          ],
        ),
      );
    }
    if (event is TapOnTakeFromCharge) {
      Charge charge = event.charge;
      TextEditingController controller = TextEditingController();
      Home home = await blackoutPreferences.getHome();
      User user = await blackoutPreferences.getUser();
      Amount amount;
      await showDialog(
        context: event.context,
        child: AlertDialog(
          content: TextField(
            autofocus: true,
            controller: controller,
          ),
          actions: [
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(event.context),
            ),
            FlatButton(
              child: Text("Accept"),
              onPressed: () async {
                amount = Amount.fromInput(controller.text, charge.product.unit);
                Change change = Change(
                  changeDate: LocalDateTime.now(),
                  home: home,
                  user: user,
                  charge: charge,
                  value: -UnitConverter.toSi(amount).value,
                );
                await changeRepository.save(change);
                chargeBloc.add(LoadCharge(charge.id));
                Navigator.pop(event.context);
              },
            )
          ],
        ),
      );
    }
  }
}
