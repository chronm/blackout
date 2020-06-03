import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/widget/changes_widget/changes_widget.dart';
import 'package:Blackout/widget/product_configuration/product_configuration.dart';
import 'package:flutter/material.dart' show BuildContext, Navigator, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ModelChangeRepository modelChangeRepository;
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  ProductBloc(this.modelChangeRepository, this.groupRepository, this.blackoutPreferences, this.productRepository);

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SaveProductAndClose) {
      User user = await blackoutPreferences.getUser();
      Product product = await productRepository.save(event.product, user);
      List<Group> groups = await groupRepository.findAllByHomeId(product.home.id);
      Navigator.pop(event.context, product);
      yield ShowProduct(product, groups);
    }
    if (event is LoadProduct) {
      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.findOneByProductIdAndHomeId(event.productId, home.id);
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowProduct(product, groups);
    }
    if (event is TapOnCharge) {
      sl<ChargeBloc>().add(LoadCharge(event.charge.id));
    }
    if (event is TapOnShowProductConfiguration) {
      showDialog(
        context: event.context,
        builder: (context) => ProductConfiguration(
          product: event.product,
          groups: event.groups,
          action: (product) => this.add(SaveProductAndClose(product, context)),
        ),
      );
    }
    if (event is TapOnShowProductChanges) {
      showDialog(
        context: event.context,
        builder: (context) => ChangesWidget(changes: event.changes),
      );
    }
  }
}
