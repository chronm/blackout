import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ItemRepository itemRepository;
  ProductRepository productRepository;
  CategoryRepository categoryRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting();
    itemRepository = _database.itemRepository;
    productRepository = _database.productRepository;
    categoryRepository = _database.categoryRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new Product', () async {
    Product product = createDefaultProduct();

    await homeRepository.save(product.home);
    product = await productRepository.save(product);

    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
  });

  test('(Save) Update a Product', () async {
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    product = await productRepository.save(product);
    String productId = product.id;

    product.description = "test";
    await productRepository.save(product);
    product = await productRepository.getOneByProductIdAndHomeId(productId, DEFAULT_HOME_ID);

    expect(product.id, equals(productId));
    expect(product.description, equals("test"));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if product to drop is no database object', () async {
    Product product = createDefaultProduct();
    expect(() => productRepository.drop(product), throwsAssertionError);
  });

  test('(Drop) Delete a product', () async {
    Product product = createDefaultProduct();

    await homeRepository.save(product.home);
    product = await productRepository.save(product);

    var result = await productRepository.drop(product);
    expect(result, equals(1));

    List<Product> products = await productRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(products.length, equals(0));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByProductId) Product contains items if recurseItems=true', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(product.home);
    product = await productRepository.save(product);
    item = await itemRepository.save(item);

    product = await productRepository.getOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);
    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.items, hasLength(1));
    expect(product.items[0].product.id, equals(product.id));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByProductId) Product does not contain items if recurseItems=false', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(product.home);
    product = await productRepository.save(product);
    item = await itemRepository.save(item);

    product = await productRepository.getOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID, recurseItems: false);
    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.items, hasLength(0));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByProductId) Return null if product not found', () async {
    Product product = await productRepository.getOneByProductIdAndHomeId("", DEFAULT_HOME_ID);

    expect(product, isNull);
  });

  test('(FindOneByProductId) Optional is empty if product not found', () async {
    Optional<Product> product = await productRepository.findOneByProductIdAndHomeId("", DEFAULT_HOME_ID);

    expect(product.isEmpty, isTrue);
  });

  test('(FindOneByProductId) Optional is present if product found)', () async {
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    product = await productRepository.save(createDefaultProduct());

    Optional<Product> optionalProduct = await productRepository.findOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);

    expect(optionalProduct.isEmpty, isFalse);
  });

  test('(FindAll) find all products', () async {
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    product = await productRepository.save(createDefaultProduct());

    List<Product> products = await productRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseItems: false);
    expect(products.length, equals(1));
  });

  test('(GetAllByCategoryId) Get all products by categoryId if recurseCategory=true', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;
    await homeRepository.save(product.home);
    category = await categoryRepository.save(category);
    product = await productRepository.save(product);

    List<Product> products = await productRepository.getAllByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID);
    expect(products.length, equals(1));
    expect(products[0].category, isNotNull);
  });

  test('(GetAllByCategoryId) Get all producty by categoryId if recurseCategory=false', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;
    await homeRepository.save(product.home);
    category = await categoryRepository.save(category);
    product = await productRepository.save(product);

    List<Product> products = await productRepository.getAllByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID, recurseCategory: false);
    expect(products.length, equals(1));
    expect(products[0].category, isNull);
  });
}
