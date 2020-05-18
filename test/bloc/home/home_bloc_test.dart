import 'package:Blackout/bloc/category/category_bloc.dart' show CategoryBloc;
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  ModelChangeRepository modelChangeRepository;
  CategoryRepository categoryRepository;
  ProductRepository productRepository;
  BlackoutPreferences blackoutPreferences;
  CategoryBloc categoryBloc;
  ProductBloc productBloc;
  HomeBloc homeBloc;

  setUp(() {
    modelChangeRepository = ModelChangeRepositoryMock();
    categoryRepository = CategoryRepositoryMock();
    productRepository = ProductRepositoryMock();
    blackoutPreferences = BlackoutPreferencesMock();
    categoryBloc = CategoryBlocMock();
    productBloc = ProductBlocMock();
    homeBloc = HomeBloc(blackoutPreferences, categoryRepository, productRepository, categoryBloc, modelChangeRepository, productBloc);
  });

  test('Load all on the home screen displayable entries', () {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    category.products = [product];
    product.category = category;
    Charge charge = createDefaultCharge();
    product.charges = [charge];
    charge.product = product;
    Change change = createDefaultChange();
    charge.changes = [change];
    change.charge = charge;
    Product product2 = product.clone()..category = null;

    when(blackoutPreferences.getHome()).thenAnswer((_) => Future.value(createDefaultHome()));
    when(categoryRepository.findAllByHomeId(DEFAULT_HOME_ID)).thenAnswer((_) => Future.value(<Category>[category]));
    when(productRepository.findAllByHomeIdAndCategoryIsNull(DEFAULT_HOME_ID)).thenAnswer((_) => Future.value(<Product>[product2]));

    expectLater(homeBloc, emitsInOrder([HomeInitialState(), Loading(), isA<LoadedAll>()]));

    homeBloc.add(LoadAll());
  });
}
