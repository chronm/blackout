import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/features/group_overview/bloc/group_bloc.dart';
import 'package:Blackout/features/product_overview/bloc/product_bloc.dart';
import 'package:bloc/bloc.dart' show Bloc;

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  HomeBloc(this.blackoutPreferences, this.groupRepository, this.productRepository);

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
      Home home = await blackoutPreferences.getHome();
      List<Group> groups = await groupRepository.findAllByHomeId(home.id);
      List<Product> products = await productRepository.findAllByHomeIdAndGroupIsNull(home.id);
      List<HomeListable> cards = <HomeListable>[]
        ..addAll(products)
        ..addAll(groups)
        ..sort((a, b) => a.title.compareTo(b.title));
      yield LoadedAll(cards);
    }
  }
}
