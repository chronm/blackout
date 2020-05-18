import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ChargeRepository chargeRepository;
  ProductRepository productRepository;
  CategoryRepository categoryRepository;
  HomeRepository homeRepository;
  UserRepository userRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    chargeRepository = _database.chargeRepository;
    productRepository = _database.productRepository;
    categoryRepository = _database.categoryRepository;
    homeRepository = _database.homeRepository;
    userRepository = _database.userRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new Product', () async {
    Product product = createDefaultProduct();

    await homeRepository.save(product.home);
    product = await productRepository.save(product, createDefaultUser());

    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
  });

  test('(Save) Update a Product', () async {
    User user = createDefaultUser();
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    product = await productRepository.save(product, user);
    String productId = product.id;

    product.description = "test";
    await productRepository.save(product, user);
    product = await productRepository.getOneByProductIdAndHomeId(productId, DEFAULT_HOME_ID);

    expect(product.id, equals(productId));
    expect(product.description, equals("test"));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if product to drop is no database object', () async {
    await productRepository.findAllByHomeId(DEFAULT_HOME_ID);
    Product product = createDefaultProduct();
    expect(() => productRepository.drop(product), throwsAssertionError);
  });

  test('(Drop) Delete a product', () async {
    Product product = createDefaultProduct();

    await homeRepository.save(product.home);
    product = await productRepository.save(product, createDefaultUser());

    var result = await productRepository.drop(product);
    expect(result, equals(1));

    List<Product> products = await productRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(products.length, equals(0));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByProductId) Product contains charges if recurseCharges=true', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(product.home);
    product = await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    product = await productRepository.getOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);
    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.charges, hasLength(1));
    expect(product.charges[0].product.id, equals(product.id));
    expect(product.home.name, equals(DEFAULT_HOME_NAME));
    expect(product.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByProductId) Product does not contain charges if recurseCharges=false', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(product.home);
    product = await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    product = await productRepository.getOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID, recurseCharges: false);
    expect(product.id, isNotNull);
    expect(product.description, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.ean, equals(DEFAULT_PRODUCT_EAN));
    expect(product.charges, hasLength(0));
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
    product = await productRepository.save(createDefaultProduct(), createDefaultUser());

    Optional<Product> optionalProduct = await productRepository.findOneByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);

    expect(optionalProduct.isEmpty, isFalse);
  });

  test('(FindAll) find all products', () async {
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    product = await productRepository.save(createDefaultProduct(), createDefaultUser());

    List<Product> products = await productRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseCharges: false);
    expect(products.length, equals(1));
  });

  test('(GetAllByCategoryId) Get all products by categoryId if recurseCategory=true', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;
    await homeRepository.save(product.home);
    category = await categoryRepository.save(category, createDefaultUser());
    product = await productRepository.save(product, createDefaultUser());

    List<Product> products = await productRepository.getAllByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID);
    expect(products.length, equals(1));
    expect(products[0].category, isNotNull);
  });

  test('(GetAllByCategoryId) Get all producty by categoryId if recurseCategory=false', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    product.category = category;
    await homeRepository.save(product.home);
    category = await categoryRepository.save(category, createDefaultUser());
    product = await productRepository.save(product, createDefaultUser());

    List<Product> products = await productRepository.getAllByCategoryIdAndHomeId(category.id, DEFAULT_HOME_ID, recurseCategory: false);
    expect(products.length, equals(1));
    expect(products[0].category, isNull);
  });

  test('(findAllByHomeIdAndCategoryIsNull) Find all products for category and without a category', () async {
    Category category = createDefaultCategory();
    Product product1 = createDefaultProduct();
    Product product2 = createDefaultProduct()..ean = "otherEan";
    product2.description = "product2";
    await homeRepository.save(product1.home);
    User user = await userRepository.save(createDefaultUser());
    category = await categoryRepository.save(category, user);
    product1 = await productRepository.save(product1, user);
    product2 = await productRepository.save(product2, user);

    List<Product> products = await productRepository.findAllByHomeIdAndCategoryIsNull(category.home.id);
    expect(products.length, equals(2));
    expect(products[0].description, DEFAULT_PRODUCT_DESCRIPTION);
    expect(products[1].description, "product2");
  });
}
