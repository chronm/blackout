import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  ModelChangeRepository modelChangeRepository;
  GroupRepository groupRepository;
  BlackoutPreferences blackoutPreferences;
  ProductRepository productRepository;
  ChargeBloc chargeBloc;
  ProductBloc productBloc;

  setUp(() {
    modelChangeRepository = ModelChangeRepositoryMock();
    blackoutPreferences = BlackoutPreferencesMock();
    groupRepository = GroupRepositoryMock();
    productRepository = ProductRepositoryMock();
    chargeBloc = ChargeBlocMock();
    productBloc = ProductBloc(modelChangeRepository, groupRepository, blackoutPreferences, productRepository, chargeBloc);
  });

  test('Save product emits ShowProduct', () {
    when(blackoutPreferences.getUser()).thenAnswer((realInvocation) => Future.value(createDefaultUser()));
    when(productRepository.save(argThat(isA<Product>()), argThat(isA<User>()))).thenAnswer((realInvocation) => Future.value(createDefaultProduct()..id = DEFAULT_PRODUCT_ID));
    when(modelChangeRepository.findAllByProductIdAndHomeId(DEFAULT_PRODUCT_ID, DEFAULT_HOME_ID)).thenAnswer((realInvocation) => Future.value([createDefaultModelChange(ModelChangeType.create, product: createDefaultProduct()..id = DEFAULT_PRODUCT_ID)]));
    when(groupRepository.findAllByHomeId(DEFAULT_HOME_ID)).thenAnswer((realInvocation) => Future.value([createDefaultGroup()]));

    expectLater(productBloc, emitsInOrder([ProductInitialState(), isA<ShowProduct>()]));

    productBloc.add(SaveProduct(createDefaultProduct()));
  });

  test('Load and show product', () {
    when(modelChangeRepository.findAllByProductIdAndHomeId(DEFAULT_PRODUCT_ID, DEFAULT_HOME_ID)).thenAnswer((realInvocation) => Future.value([createDefaultModelChange(ModelChangeType.create, product: createDefaultProduct()..id = DEFAULT_PRODUCT_ID)]));
    when(blackoutPreferences.getHome()).thenAnswer((realInvocation) => Future.value(createDefaultHome()));
    when(productRepository.getOneByProductIdAndHomeId(argThat(isA<Product>()), argThat(isA<User>()))).thenAnswer((realInvocation) => Future.value(createDefaultProduct()));
    when(groupRepository.findAllByHomeId(DEFAULT_HOME_ID)).thenAnswer((realInvocation) => Future.value([createDefaultGroup()]));

    expectLater(productBloc, emitsInOrder([ProductInitialState(), isA<ShowProduct>()]));

    productBloc.add(LoadProduct(DEFAULT_PRODUCT_ID));
  });
}
