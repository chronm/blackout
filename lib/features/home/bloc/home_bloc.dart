import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/home_listable.dart';
import '../../../models/product.dart';
import '../../group/bloc/group_bloc.dart';
import '../../product/bloc/product_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  HomeBloc(this.blackoutPreferences, this.groupRepository, this.productRepository);

  @override
  HomeState get initialState => HomeInitialState();

  var _cards = <HomeListable>[];

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is TapOnGroup) {
      sl<GroupBloc>().add(UseGroup(event.group));
      yield GoToGroup();
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(UseProduct(event.product));
      yield GoToProduct();
    }
    if (event is LoadAll) {
      yield Loading();
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id, usedCached: false);
      var products = await productRepository.findAllByHomeIdAndGroupIsNull(home.id);
      var cards = <HomeListable>[]
        ..addAll(products)
        ..addAll(groups)
        ..sort((a, b) => a.title.compareTo(b.title));
      _cards = cards;
    }
    if (event is UseCards) {
      _cards = event.cards;
      yield LoadedAll(_cards);
    }
    if (event is Redraw) {
      yield LoadedAll(_cards);
    }
  }
}
