import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/group.dart';
import '../../../models/product.dart';
import '../../batch/cubit/batch_cubit.dart';
import '../../group/cubit/group_cubit.dart';
import '../../home/cubit/home_cubit.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  ProductCubit(this.groupRepository, this.blackoutPreferences, this.productRepository) : super(ProductInitialState());

  Product _product;

  void saveProduct(Product product) async {
    var user = await blackoutPreferences.getUser();
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    _product = await productRepository.save(product, user);
    if (_product.group != null) {
      sl<GroupCubit>().loadGroup(_product.group.id);
    }
    sl<HomeCubit>().loadAll();
    emit(ShowProduct(_product, groups));
  }

  void useProduct(Product product) async {
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    emit(ShowProduct(product, groups));
  }

  void loadProduct(String productId) async {
    _product = await productRepository.findOneByProductId(productId);
  }

  void tapOnBatch(Batch batch) async {
    sl<BatchCubit>().useBatch(batch);
    emit(GoToBatch(batch.product.id));
  }

  void tapOnDeleteProduct(Product product) async {
    var user = await blackoutPreferences.getUser();
    _product = null;
    productRepository.drop(product, user);
    if (product.group != null) {
      sl<GroupCubit>().loadGroup(product.group.id);
    }
    sl<HomeCubit>().loadAll();
    emit(GoBack());
  }

  void redraw() async {
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id);
    emit(ShowProduct(_product, groups));
  }
}
