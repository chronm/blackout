import 'package:Blackout/bloc/group/group_bloc.dart' show GroupBloc, LoadGroup;
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart' show LoadProduct, ProductBloc;
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/routes.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/material.dart' show BuildContext, Navigator;

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ModelChangeRepository modelChangeRepository;
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;
  final GroupBloc groupBloc;
  final ProductBloc productBloc;

  HomeBloc(this.blackoutPreferences, this.groupRepository, this.productRepository, this.groupBloc, this.modelChangeRepository, this.productBloc);

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is TapOnGroup) {
      groupBloc.add(LoadGroup(event.group.id));
      Navigator.push(event.context, RouteBuilder.build(Routes.GroupOverviewRoute));
    }
    if (event is TapOnProduct) {
      productBloc.add(LoadProduct(event.product.id));
      Navigator.push(event.context, RouteBuilder.build(Routes.ProductOverviewRoute));
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
