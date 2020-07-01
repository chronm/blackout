import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bloc/bloc.dart';
import 'package:time_machine/time_machine.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/change_repository.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/change.dart';
import '../../../models/group.dart';
import '../../../models/home.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../batch/bloc/batch_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../product/bloc/product_bloc.dart';

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
      if (emulator) {
        ean = "someEan";
      } else {
        var options = ScanOptions(restrictFormat: [BarcodeFormat.ean8, BarcodeFormat.ean13]);
        var result = await BarcodeScanner.scan(options: options);
        ean = result.rawContent;
      }

      var home = await blackoutPreferences.getHome();
      var product = await productRepository.findOneByPatternAndHomeId(ean, home.id);
      if (product != null) {
        sl<ProductBloc>().add(LoadProduct(product.id));
        yield GoToProduct();
      } else {
        var groups = await groupRepository.findAllByHomeId(home.id);
        if (ean == "") ean = null;
        yield ShowCreateProduct(home, groups, ean);
      }
    }
    if (event is TapOnCreateBatch) {
      yield ShowCreateBatch(event.product, event.product.id);
    }
    if (event is TapOnCreateProduct) {
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowCreateProduct(home, groups, null);
    }
    if (event is TapOnCreateProductInGroup) {
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowCreateProductInGroup(home, groups, event.group, event.group.id);
    }
    if (event is TapOnCreateGroup) {
      var home = await blackoutPreferences.getHome();
      yield ShowCreateGroup(home);
    }
    if (event is TapOnCreateGroupForProduct) {
      var home = await blackoutPreferences.getHome();
      yield ShowCreateGroupForProduct(home);
    }
    if (event is TapOnGotoHome) {
      sl<HomeBloc>().add(LoadAll());
      yield GoToHome();
    }
    if (event is AddToBatch) {
      var batch = event.batch;
      var home = await blackoutPreferences.getHome();
      var user = await blackoutPreferences.getUser();
      var amount = Amount.fromInput(event.amount, batch.product.unit);
      var change = Change(
        changeDate: LocalDate.today(),
        user: user,
        batch: batch,
        value: UnitConverter.toSi(amount).value,
        home: home,
      );
      await changeRepository.save(change);
      sl<BatchBloc>().add(LoadBatch(batch.id));
    }
    if (event is TakeFromBatch) {
      var batch = event.batch;
      var home = await blackoutPreferences.getHome();
      var user = await blackoutPreferences.getUser();
      var amount = Amount.fromInput(event.amount, batch.product.unit);
      var change = Change(
        changeDate: LocalDate.today(),
        user: user,
        batch: batch,
        value: UnitConverter.toSi(amount).value,
        home: home,
      );
      await changeRepository.save(change);
      sl<BatchBloc>().add(LoadBatch(batch.id));
    }
  }
}
