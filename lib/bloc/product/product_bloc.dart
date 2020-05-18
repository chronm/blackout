import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ModelChangeRepository modelChangeRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;
  final ChargeBloc chargeBloc;

  ProductBloc(this.modelChangeRepository, this.categoryRepository, this.blackoutPreferences, this.productRepository, this.chargeBloc);

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SaveProduct) {
      User user = await blackoutPreferences.getUser();
      Product product = await productRepository.save(event.product, user);
      List<Category> categories = await categoryRepository.findAllByHomeId(product.home.id);
      yield ShowProduct(product, categories);
    }
    if (event is LoadProduct) {
      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.getOneByProductIdAndHomeId(event.productId, home.id);
      List<Category> categories = await categoryRepository.findAllByHomeId(home.id);
      yield ShowProduct(product, categories);
    }
    if (event is TapOnCharge) {
      chargeBloc.add(LoadCharge(event.charge.id));
    }
  }
}
