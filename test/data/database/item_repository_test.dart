import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ProductRepository productRepository;
  ItemRepository itemRepository;
  ChangeRepository changeRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    productRepository = _database.productRepository;
    itemRepository = _database.itemRepository;
    changeRepository = _database.changeRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new item', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    expect(item.id, isNotNull);
    expect(item.home.name, equals(DEFAULT_HOME_NAME));
    expect(item.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Save) Update an item', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());
    String itemId = item.id;

    item.expirationDate = LocalDateTime(2000, 1, 1, 0, 0, 0);
    await itemRepository.save(item, createDefaultUser());
    item = await itemRepository.getOneByItemIdAndHomeId(itemId, DEFAULT_HOME_ID);

    expect(item.id, equals(itemId));
    expect(item.expirationDate, equals(LocalDateTime(2000, 1, 1, 0, 0, 0)));
    expect(item.home.name, equals(DEFAULT_HOME_NAME));
    expect(item.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if item to drop is no database object', () async {
    await itemRepository.findAllByHomeId(DEFAULT_HOME_ID);
    Item item = createDefaultItem();
    expect(() => itemRepository.drop(item), throwsAssertionError);
  });

  test('(Drop) Delete an item', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    var result = await itemRepository.drop(item);
    expect(result, equals(1));

    List<Item> items = await itemRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(items.length, equals(0));
  });

  test('(GetOneByItemId) Item contains items if recurseChanges=true', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;
    Change change = createDefaultChange();
    change.item = item;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());
    change = await changeRepository.save(change);

    item = await itemRepository.getOneByItemIdAndHomeId(item.id, DEFAULT_HOME_ID);
    expect(item.id, isNotNull);
    expect(item.changes, hasLength(1));
    expect(item.changes[0].item.id, equals(item.id));
    expect(item.home.name, equals(DEFAULT_HOME_NAME));
    expect(item.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByItemId) Item does not contain items if recurseChanges=false', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;
    Change change = createDefaultChange();
    change.item = item;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());
    change = await changeRepository.save(change);

    item = await itemRepository.getOneByItemIdAndHomeId(item.id, DEFAULT_HOME_ID, recurseChanges: false);
    expect(item.id, isNotNull);
    expect(item.changes, hasLength(0));
    expect(item.home.name, equals(DEFAULT_HOME_NAME));
    expect(item.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByItemId) Return null if item not found', () async {
    Item item = await itemRepository.getOneByItemIdAndHomeId("", DEFAULT_HOME_ID);

    expect(item, isNull);
  });

  test('(FindOneByItemId) Optional is empty if item not found', () async {
    Optional<Item> item = await itemRepository.findOneByItemIdAndHomeId("", DEFAULT_HOME_ID);

    expect(item.isEmpty, isTrue);
  });

  test('(FindOneByItemId) Optional is present if item found)', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    Optional<Item> optionalItem = await itemRepository.findOneByItemIdAndHomeId(item.id, DEFAULT_HOME_ID);

    expect(optionalItem.isEmpty, isFalse);
  });

  test('(FindAll) find all items', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;

    await homeRepository.save(item.home);
    await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    List<Item> items = await itemRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseChanges: false);
    expect(items.length, equals(1));
  });

  test('(GetAllByProductId) Get all items by productId if recurseProduct=true', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;
    await homeRepository.save(item.home);
    product = await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    List<Item> items = await itemRepository.getAllByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);
    expect(items.length, equals(1));
    expect(items[0].product, isNotNull);
  });

  test('(GetAllByProductId) Get all items by productId if recurseProduct=false', () async {
    Product product = createDefaultProduct();
    Item item = createDefaultItem();
    item.product = product;
    await homeRepository.save(item.home);
    product = await productRepository.save(product, createDefaultUser());
    item = await itemRepository.save(item, createDefaultUser());

    List<Item> items = await itemRepository.getAllByProductIdAndHomeId(product.id, DEFAULT_HOME_ID, recurseProduct: false);
    expect(items.length, equals(1));
    expect(items[0].product, isNull);
  });
}
