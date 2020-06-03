import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ProductRepository productRepository;
  ChargeRepository chargeRepository;
  ChangeRepository changeRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    productRepository = _database.productRepository;
    chargeRepository = _database.chargeRepository;
    changeRepository = _database.changeRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new charge', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    expect(charge.id, isNotNull);
    expect(charge.home.name, equals(DEFAULT_HOME_NAME));
    expect(charge.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Save) Update an charge', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());
    String chargeId = charge.id;

    charge.expirationDate = LocalDate(2000, 1, 1, 0, 0, 0);
    await chargeRepository.save(charge, createDefaultUser());
    charge = await chargeRepository.findOneByChargeIdAndHomeId(chargeId, DEFAULT_HOME_ID);

    expect(charge.id, equals(chargeId));
    expect(charge.expirationDate, equals(LocalDate(2000, 1, 1, 0, 0, 0)));
    expect(charge.home.name, equals(DEFAULT_HOME_NAME));
    expect(charge.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if charge to drop is no database object', () async {
    await chargeRepository.findAllByHomeId(DEFAULT_HOME_ID);
    Charge charge = createDefaultCharge();
    expect(() => chargeRepository.drop(charge), throwsAssertionError);
  });

  test('(Drop) Delete an charge', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    var result = await chargeRepository.drop(charge);
    expect(result, equals(1));

    List<Charge> charges = await chargeRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(charges.length, equals(0));
  });

  test('(GetOneByChargeId) Charge contains charges if recurseChanges=true', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;
    Change change = createDefaultChange();
    change.charge = charge;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());
    change = await changeRepository.save(change);

    charge = await chargeRepository.findOneByChargeIdAndHomeId(charge.id, DEFAULT_HOME_ID);
    expect(charge.id, isNotNull);
    expect(charge.changes, hasLength(1));
    expect(charge.changes[0].charge.id, equals(charge.id));
    expect(charge.home.name, equals(DEFAULT_HOME_NAME));
    expect(charge.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByChargeId) Charge does not contain charges if recurseChanges=false', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;
    Change change = createDefaultChange();
    change.charge = charge;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());
    change = await changeRepository.save(change);

    charge = await chargeRepository.findOneByChargeIdAndHomeId(charge.id, DEFAULT_HOME_ID, recurseChanges: false);
    expect(charge.id, isNotNull);
    expect(charge.changes, hasLength(0));
    expect(charge.home.name, equals(DEFAULT_HOME_NAME));
    expect(charge.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByChargeId) Return null if charge not found', () async {
    Charge charge = await chargeRepository.findOneByChargeIdAndHomeId("", DEFAULT_HOME_ID);

    expect(charge, isNull);
  });

  test('(FindOneByChargeId) Optional is empty if charge not found', () async {
    Optional<Charge> charge = await chargeRepository.findOneByChargeIdAndHomeId("", DEFAULT_HOME_ID);

    expect(charge.isEmpty, isTrue);
  });

  test('(FindOneByChargeId) Optional is present if charge found)', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    Optional<Charge> optionalCharge = await chargeRepository.findOneByChargeIdAndHomeId(charge.id, DEFAULT_HOME_ID);

    expect(optionalCharge.isEmpty, isFalse);
  });

  test('(FindAll) find all charges', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;

    await homeRepository.save(charge.home);
    await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    List<Charge> charges = await chargeRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseChanges: false);
    expect(charges.length, equals(1));
  });

  test('(GetAllByProductId) Get all charges by productId if recurseProduct=true', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;
    await homeRepository.save(charge.home);
    product = await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    List<Charge> charges = await chargeRepository.findAllByProductIdAndHomeId(product.id, DEFAULT_HOME_ID);
    expect(charges.length, equals(1));
    expect(charges[0].product, isNotNull);
  });

  test('(GetAllByProductId) Get all charges by productId if recurseProduct=false', () async {
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    charge.product = product;
    await homeRepository.save(charge.home);
    product = await productRepository.save(product, createDefaultUser());
    charge = await chargeRepository.save(charge, createDefaultUser());

    List<Charge> charges = await chargeRepository.findAllByProductIdAndHomeId(product.id, DEFAULT_HOME_ID, recurseProduct: false);
    expect(charges.length, equals(1));
    expect(charges[0].product, isNull);
  });
}
