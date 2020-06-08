import 'dart:async';

import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/group/group_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/charge_configuration/charge_configuration.dart';
import 'package:Blackout/widget/group_configuration/group_configuration.dart';
import 'package:Blackout/widget/product_configuration/product_configuration.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show AlertDialog, BuildContext, FlatButton, Navigator, Text, TextEditingController, TextField, showDialog;
import 'package:time_machine/time_machine.dart';

part 'speed_dial_event.dart';
part 'speed_dial_state.dart';

class SpeedDialBloc extends Bloc<SpeedDialEvent, SpeedDialState> {
  final BlackoutPreferences blackoutPreferences;
  final ChangeRepository changeRepository;
  final ProductRepository productRepository;
  final GroupRepository groupRepository;
  final HomeBloc homeBloc;
  final ChargeBloc chargeBloc;
  final ProductBloc productBloc;
  final GroupBloc groupBloc;

  SpeedDialBloc(this.productRepository, this.blackoutPreferences, this.productBloc, this.homeBloc, this.groupBloc, this.chargeBloc, this.changeRepository, this.groupRepository);

  @override
  SpeedDialState get initialState => InitialSpeedDialState();

  @override
  Stream<SpeedDialState> mapEventToState(SpeedDialEvent event) async* {
    if (event is TapOnScanEan) {
      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.findOneByEanAndHomeId(event.ean, home.id);
      if (product != null) {
        productBloc.add(LoadProduct(product.id));
        Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
      } else {
        List<Group> groups = await groupRepository.findAllByHomeId(home.id);
        Product result = await showDialog<Product>(
          context: event.context,
          builder: (context) => ProductConfiguration(
            product: Product(ean: event.ean, description: "", unit: UnitEnum.unitless, home: home),
            newProduct: true,
            groups: groups,
            action: (product) => productBloc.add(SaveProductAndClose(product, event.context)),
          ),
        );
        if (result != null) {
          Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
          sl<HomeBloc>().add(LoadAll());
        }
      }
    }
    if (event is TapOnCreateCharge) {
      Home home = await blackoutPreferences.getHome();
      Charge result = await showDialog<Charge>(
        context: event.context,
        builder: (context) => ChargeConfiguration(
          charge: Charge(home: home, product: event.product),
          newCharge: true,
          action: (charge) {
            chargeBloc.add(SaveChargeAndClose(charge, context));
          },
        ),
      );
      if (result != null) {
        Navigator.push(event.context, RouteBuilder.build(Routes.ChargeOverviewRoute));
        sl<ProductBloc>().add(LoadProduct(event.product.id));
        sl<HomeBloc>().add(LoadAll());
      }
    }
    if (event is TapOnCreateProduct) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      Product result = await showDialog<Product>(
        context: event.context,
        builder: (context) => ProductConfiguration(
          product: Product(home: home, description: "", unit: UnitEnum.unitless, group: event.group),
          newProduct: true,
          groups: groups,
          action: (product) {
            productBloc.add(SaveProductAndClose(product, context));
          },
        ),
      );
      if (result != null) {
        Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
        if (event.group != null) {
          sl<GroupBloc>().add(LoadGroup(event.group.id));
        }
        sl<HomeBloc>().add(LoadAll());
      }
    }
    if (event is TapOnCreateGroup) {
      Home home = await blackoutPreferences.getHome();
      Group result = await showDialog<Group>(
        context: event.context,
        builder: (context) => GroupConfiguration(
          group: Group(home: home, name: "", unit: UnitEnum.unitless),
          newGroup: true,
          action: (group) {
            groupBloc.add(SaveGroupAndClose(group, context));
          },
        ),
      );
      if (result != null) {
        Navigator.push(event.context, RouteBuilder.build(Routes.GroupOverviewRoute));
        sl<HomeBloc>().add(LoadAll());
      }
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
                  changeDate: LocalDate.today(),
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
      if (amount != null) {
        sl<ChargeBloc>().add(LoadCharge(charge.id));
        sl<ProductBloc>().add(LoadProduct(charge.product.id));
        if (charge.product.group != null) {
          sl<GroupBloc>().add(LoadGroup(charge.product.group.id));
        }
        sl<HomeBloc>().add(LoadAll());
      }
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
                  changeDate: LocalDate.today(),
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
      if (amount != null) {
        sl<ChargeBloc>().add(LoadCharge(charge.id));
        sl<ProductBloc>().add(LoadProduct(charge.product.id));
        if (charge.product.group != null) {
          sl<GroupBloc>().add(LoadGroup(charge.product.group.id));
        }
        sl<HomeBloc>().add(LoadAll());
      }
    }
  }
}
