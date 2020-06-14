import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      User user = await blackoutPreferences.getUser();
      Product product = await productRepository.save(event.product, user);
      List<Group> groups = await groupRepository.findAllByHomeId(product.home.id);
      yield ShowProduct(product, groups);
    }
    if (event is LoadProduct) {
      Home home = await blackoutPreferences.getHome();
      Product product = await productRepository.findOneByProductId(event.productId);
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      yield ShowProduct(product, groups);
    }
    if (event is TapOnCharge) {
      sl<ChargeBloc>().add(LoadCharge(event.charge.id));
      yield GoToCharge(event.charge.product.id);
    }
  }
}
