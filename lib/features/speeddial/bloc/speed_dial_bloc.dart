import 'dart:async';

import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/features/product/bloc/product_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/features/home/bloc/home_bloc.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:time_machine/time_machine.dart';

part 'speed_dial_event.dart';

part 'speed_dial_state.dart';

class SpeedDialBloc extends Bloc<SpeedDialEvent, SpeedDialState> {
  final BlackoutPreferences blackoutPreferences;
  final ChangeRepository changeRepository;
  final ProductRepository productRepository;
  final GroupRepository groupRepository;

  SpeedDialBloc(this.productRepository, this.blackoutPreferences, this.changeRepository, this.groupRepository);

  @override
  SpeedDialState get initialState => InitialSpeedDialState();

  @override
  Stream<SpeedDialState> mapEventToState(SpeedDialEvent event) async* {
    if (event is TapOnScanEan) {
      String ean;
      if (isEmulator) {
        ean = "someEan";
      } else {
        var options = ScanOptions(restrictFormat: [BarcodeFormat.ean8, BarcodeFormat.ean13]);
        var result = await BarcodeScanner.scan(options: options);
        ean = result.rawContent;
      }

      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.findOneByEanAndHomeId(ean, home.id);
      if (product != null) {
        sl<ProductBloc>().add(LoadProduct(product.id));
        yield GoToProduct();
      } else {
        List<Group> groups = await groupRepository.findAllByHomeId(home.id);
        yield ShowCreateProduct(home, groups, ean);
      }
    }
    if (event is TapOnCreateCharge) {
      yield ShowCreateCharge(event.product, event.product.id);
    }
    if (event is TapOnCreateProduct) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowCreateProduct(home, groups, null);
    }
    if (event is TapOnCreateProductInGroup) {
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowCreateProductInGroup(home, groups, event.group, event.group.id);
    }
    if (event is TapOnCreateGroup) {
      Home home = await blackoutPreferences.getHome();
      yield ShowCreateGroup(home);
    }
    if (event is TapOnCreateGroupForProduct) {
      Home home = await blackoutPreferences.getHome();
      yield ShowCreateGroupForProduct(home);
    }
    if (event is TapOnGotoHome) {
      sl<HomeBloc>().add(LoadAll());
      yield GoToHome();
    }
    if (event is AddToCharge) {
      Charge charge = event.charge;
      Home home = await blackoutPreferences.getHome();
      User user = await blackoutPreferences.getUser();
      Amount amount = Amount.fromInput(event.amount, charge.product.unit);
      Change change = Change(
        changeDate: LocalDate.today(),
        user: user,
        charge: charge,
        value: UnitConverter.toSi(amount).value,
        home: home,
      );
      await changeRepository.save(change);
      sl<ChargeBloc>().add(LoadCharge(charge.id));
    }
    if (event is TakeFromCharge) {
      Charge charge = event.charge;
      Home home = await blackoutPreferences.getHome();
      User user = await blackoutPreferences.getUser();
      Amount amount = Amount.fromInput(event.amount, charge.product.unit);
      Change change = Change(
        changeDate: LocalDate.today(),
        user: user,
        charge: charge,
        value: UnitConverter.toSi(amount).value,
        home: home,
      );
      await changeRepository.save(change);
      sl<ChargeBloc>().add(LoadCharge(charge.id));
    }
  }
}
