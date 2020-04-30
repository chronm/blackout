import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  CategoryRepository categoryRepository;
  ModelChangeRepository modelChangeRepository;
  BlackoutPreferences blackoutPreferences;
  CategoryBloc categoryBloc;
  ProductBloc productBloc;

  setUp(() {
    categoryRepository = CategoryRepositoryMock();
    modelChangeRepository = ModelChangeRepositoryMock();
    blackoutPreferences = BlackoutPreferencesMock();
    categoryBloc = CategoryBloc(categoryRepository, modelChangeRepository, blackoutPreferences, productBloc);
  });

  test('Save category emits ShowCategory', () {
    when(blackoutPreferences.getUser()).thenAnswer((_) => Future.value(createDefaultUser()));
    when(categoryRepository.save(argThat(isA<Category>()), argThat(isA<User>()))).thenAnswer((_) => Future.value(createDefaultCategory()..id = DEFAULT_CATEGORY_ID));
    when(modelChangeRepository.findAllByCategoryIdAndHomeId(DEFAULT_CATEGORY_ID, DEFAULT_HOME_ID)).thenAnswer((_) => Future.value([createDefaultModelChange(ModelChangeType.create, category: createDefaultCategory()..id = DEFAULT_CATEGORY_ID)]));

    expectLater(categoryBloc, emitsInOrder([InitialCategoryState(), isA<ShowCategory>()]));

    categoryBloc.add(SaveCategory(createDefaultCategory()));
  });

  test('Load category, coming from HomeScreen emits ShowCategory', () {
    when(modelChangeRepository.findAllByCategoryIdAndHomeId(DEFAULT_CATEGORY_ID, DEFAULT_HOME_ID)).thenAnswer((_) => Future.value([createDefaultModelChange(ModelChangeType.create, category: createDefaultCategory()..id = DEFAULT_CATEGORY_ID)]));

    expectLater(categoryBloc, emitsInOrder([InitialCategoryState(), isA<ShowCategory>()]));

    categoryBloc.add(LoadCategory(createDefaultCategory()..id = DEFAULT_CATEGORY_ID));
  });
}
