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

  HomeBloc(
      this.blackoutPreferences, this.groupRepository, this.productRepository);

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is TapOnGroup) {
      sl<GroupBloc>().add(LoadGroup(event.group.id));
      yield GoToGroup();
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(LoadProduct(event.product.id));
      yield GoToProduct();
    }
    if (event is LoadAll) {
      yield Loading();
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id);
      var products =
          await productRepository.findAllByHomeIdAndGroupIsNull(home.id);
      var cards = <HomeListable>[]
        ..addAll(products)
        ..addAll(groups)
        ..sort((a, b) => a.title.compareTo(b.title));
      yield LoadedAll(cards);
    }
  }
}
