import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../batch/bloc/batch_bloc.dart';
import '../../group/bloc/group_bloc.dart';
import '../../home/bloc/home_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  ProductBloc(this.groupRepository, this.blackoutPreferences, this.productRepository);

  @override
  ProductState get initialState => ProductInitialState();

  Product _product;

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SaveProduct) {
      var user = await blackoutPreferences.getUser();
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      _product = await productRepository.save(event.product, user);
      if (_product.group != null) {
        sl<GroupBloc>().add(LoadGroup(_product.group.id));
        sl<HomeBloc>().add(LoadAll());
      }
      yield ShowProduct(_product, groups);
    }
    if (event is UseProduct) {
      _product = event.product;
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowProduct(event.product, groups);
    }
    if (event is LoadProduct) {
      _product = await productRepository.findOneByProductId(event.productId);
    }
    if (event is TapOnBatch) {
      sl<BatchBloc>().add(UseBatch(event.batch));
      yield GoToBatch(event.batch.product.id);
    }
    if (event is TapOnDeleteProduct) {
      var user = await blackoutPreferences.getUser();
      _product = null;
      productRepository.drop(event.product, user);
      if (event.product.group != null) {
        sl<GroupBloc>().add(LoadGroup(event.product.group.id));
      }
      sl<HomeBloc>().add(LoadAll());
      yield GoBack();
    }
    if (event is Redraw) {
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowProduct(_product, groups);
    }
  }
}
