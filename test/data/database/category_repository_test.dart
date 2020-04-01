import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ProductRepository productRepository;
  CategoryRepository categoryRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting();
    productRepository = _database.productRepository;
    categoryRepository = _database.categoryRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new category', () async {
    Category category = createDefaultCategory();

    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);

    expect(category.id, isNotNull);
    expect(category.name, equals(DEFAULT_CATEGORY_NAME));
    expect(category.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(category.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
  });

  test('(Save) Update a category', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);
    String categoryId = category.id;

    category.name = "test";
    await categoryRepository.save(category);
    category = await categoryRepository.getOneByCategoryIdAndHomeId(categoryId, DEFAULT_HOME_ID);

    expect(category.id, equals(categoryId));
    expect(category.name, equals("test"));
    expect(category.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(category.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(category.home.name, equals(DEFAULT_HOME_NAME));
    expect(category.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if category to drop is no database object', () async {
    Category category = createDefaultCategory();
    expect(() => categoryRepository.drop(category), throwsAssertionError);
  });

  test('(Drop) Delete a category', () async {
    Category category = createDefaultCategory();

    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);

    var result = await categoryRepository.drop(category);
    expect(result, equals(1));

    List<Category> categories = await categoryRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(categories.length, equals(0));
    expect(category.home.name, equals(DEFAULT_HOME_NAME));
    expect(category.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByCategoryId) Category contains Syncs if recurseSyncs=true', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;

    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);
    product = await productRepository.save(product);

    category = await categoryRepository.getOneByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID);
    expect(category.id, isNotNull);
    expect(category.name, equals(DEFAULT_CATEGORY_NAME));
    expect(category.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(category.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(category.products, hasLength(1));
    expect(category.products[0].category.id, equals(category.id));
    expect(category.home.name, equals(DEFAULT_HOME_NAME));
    expect(category.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByCategoryId) Category does not contain products if recurseProducts=false', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;

    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);
    product = await productRepository.save(product);

    category = await categoryRepository.getOneByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID, recurseProducts: false);
    expect(category.id, isNotNull);
    expect(category.name, equals(DEFAULT_CATEGORY_NAME));
    expect(category.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(category.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(category.products, hasLength(0));
    expect(category.home.name, equals(DEFAULT_HOME_NAME));
    expect(category.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByCategoryId) Return null if category not found', () async {
    Category category = await categoryRepository.getOneByCategoryIdAndHomeId("", DEFAULT_HOME_ID);

    expect(category, isNull);
  });

  test('(FindOneByCategoryId) Optional is empty if category not found', () async {
    Optional<Category> category = await categoryRepository.findOneByCategoryIdAndHomeId("", DEFAULT_HOME_ID);

    expect(category.isEmpty, isTrue);
  });

  test('(FindOneByCategoryId) Optional is present if category found)', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    category = await categoryRepository.save(category);

    Optional<Category> optionalCategory = await categoryRepository.findOneByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID);

    expect(optionalCategory.isEmpty, isFalse);
  });

  test('(FindAll) find all categories', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    await categoryRepository.save(category);

    List<Category> categories = await categoryRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseProducts: false);
    expect(categories.length, equals(1));
  });
}
