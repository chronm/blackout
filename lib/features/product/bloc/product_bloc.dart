import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/charge.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../charge/bloc/charge_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  ProductBloc(this.groupRepository, this.blackoutPreferences, this.productRepository);

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SaveProduct) {
      var user = await blackoutPreferences.getUser();
      var product = await productRepository.save(event.product, user);
      var groups = await groupRepository.findAllByHomeId(product.home.id);
      yield ShowProduct(product, groups);
    }
    if (event is LoadProduct) {
      var home = await blackoutPreferences.getHome();
      var product = await productRepository.findOneByProductId(event.productId);
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowProduct(product, groups);
    }
    if (event is TapOnCharge) {
      sl<ChargeBloc>().add(LoadCharge(event.charge.id));
      yield GoToCharge(event.charge.product.id);
    }
    if (event is TapOnDeleteProduct) {
      var user = await blackoutPreferences.getUser();
      productRepository.drop(event.product, user);
    }
  }
}
