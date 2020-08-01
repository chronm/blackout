import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:time_machine/time_machine.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/change_repository.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/change.dart' show Change;
import '../../../models/group.dart';
import '../../../models/home.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../batch/cubit/batch_cubit.dart';
import '../../group/cubit/group_cubit.dart' show GroupCubit;
import '../../home/cubit/home_cubit.dart' show HomeCubit;
import '../../product/cubit/product_cubit.dart' show ProductCubit;

part 'speed_dial_event.dart';
part 'speed_dial_state.dart';

class SpeedDialCubit extends Cubit<SpeedDialState> {
  final BlackoutPreferences blackoutPreferences;
  final ChangeRepository changeRepository;
  final ProductRepository productRepository;
  final GroupRepository groupRepository;

  SpeedDialCubit(this.productRepository, this.blackoutPreferences, this.changeRepository, this.groupRepository) : super(InitialSpeedDialState());

  void tapOnScanEan() async {
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
      sl<ProductCubit>().loadProduct(product.id);
      emit(GoToProduct());
    } else {
      var groups = await groupRepository.findAllByHomeId(home.id);
      if (ean == "") ean = null;
      emit(GoToCreateProduct(home, groups, ean));
    }
  }

  void tapOnCreateBatch(Product product) {
    emit(GoToCreateBatch(product));
  }

  void tapOnCreateProduct() async {
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    emit(GoToCreateProduct(home, groups, null));
  }

  void tapOnCreateProductInGroup(Group group) async {
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    emit(GoToCreateProductInGroup(home, groups, group));
  }

  void tapOnCreateGroup() async {
    var home = await blackoutPreferences.getHome();
    emit(GoToCreateGroup(home));
  }

  void tapOnCreateGroupForProduct() async {
    var home = await blackoutPreferences.getHome();
    emit(GoToCreateGroupForProduct(home));
  }

  void tapOnGoToHome() {
    sl<HomeCubit>().redraw();
  }

  void addToBatch(Batch batch, String input) async {
    var home = await blackoutPreferences.getHome();
    var user = await blackoutPreferences.getUser();
    var amount = Amount.fromInput(input, batch.product.unit);
    var change = Change(
      changeDate: LocalDate.today(),
      user: user,
      batch: batch,
      value: UnitConverter.toSi(amount).value,
      home: home,
    );
    await changeRepository.save(change);
    sl<BatchCubit>().loadBatch(batch.id);
    sl<ProductCubit>().loadProduct(batch.product.id);
    if (batch.product.group != null) {
      sl<GroupCubit>().loadGroup(batch.product.group.id);
    }
    sl<HomeCubit>().loadAll();
  }

  void takeFromBatch(Batch batch, String input) async {
    var home = await blackoutPreferences.getHome();
    var user = await blackoutPreferences.getUser();
    var amount = Amount.fromInput(input, batch.product.unit);
    var change = Change(
      changeDate: LocalDate.today(),
      user: user,
      batch: batch,
      value: UnitConverter.toSi(amount).value,
      home: home,
    );
    await changeRepository.save(change);
    sl<BatchCubit>().loadBatch(batch.id);
    sl<ProductCubit>().loadProduct(batch.product.id);
    if (batch.product.group != null) {
      sl<GroupCubit>().loadGroup(batch.product.group.id);
    }
    sl<HomeCubit>().loadAll;
  }
}
