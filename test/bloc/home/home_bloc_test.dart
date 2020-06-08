import 'package:Blackout/bloc/group/group_bloc.dart' show GroupBloc;
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  ModelChangeRepository modelChangeRepository;
  GroupRepository groupRepository;
  ProductRepository productRepository;
  BlackoutPreferences blackoutPreferences;
  GroupBloc groupBloc;
  ProductBloc productBloc;
  HomeBloc homeBloc;

  setUp(() {
    modelChangeRepository = ModelChangeRepositoryMock();
    groupRepository = GroupRepositoryMock();
    productRepository = ProductRepositoryMock();
    blackoutPreferences = BlackoutPreferencesMock();
    groupBloc = GroupBlocMock();
    productBloc = ProductBlocMock();
    homeBloc = HomeBloc(blackoutPreferences, groupRepository, productRepository, groupBloc, modelChangeRepository, productBloc);
  });

  test('Load all on the home screen displayable entries', () {
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    group.products = [product];
    product.group = group;
    Charge charge = createDefaultCharge();
    product.charges = [charge];
    charge.product = product;
    Change change = createDefaultChange();
    charge.changes = [change];
    change.charge = charge;
    Product product2 = product.clone()..group = null;

    when(blackoutPreferences.getHome()).thenAnswer((_) => Future.value(createDefaultHome()));
    when(groupRepository.findAllByHomeId(DEFAULT_HOME_ID)).thenAnswer((_) => Future.value(<Group>[group]));
    when(productRepository.findAllByHomeIdAndGroupIsNull(DEFAULT_HOME_ID)).thenAnswer((_) => Future.value(<Product>[product2]));

    expectLater(homeBloc, emitsInOrder([HomeInitialState(), Loading(), isA<LoadedAll>()]));

    homeBloc.add(LoadAll());
  });
}
