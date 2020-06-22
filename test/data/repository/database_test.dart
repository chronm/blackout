import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

Future<void> insertAll() async {}

void main() {
  Database _database;
  ChangeRepository changeRepository;
  ChargeRepository chargeRepository;
  ProductRepository productRepository;
  GroupRepository groupRepository;
  UserRepository userRepository;
  HomeRepository homeRepository;
  ModelChangeRepository modelChangeRepository;

  setUp(() {
    _database = Database.forTesting();
    changeRepository = _database.changeRepository;
    chargeRepository = _database.chargeRepository;
    productRepository = _database.productRepository;
    groupRepository = _database.groupRepository;
    userRepository = _database.userRepository;
    homeRepository = _database.homeRepository;
    modelChangeRepository = _database.modelChangeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('Inserting and updating', () async {
    var change = createDefaultChange()..id = null;
    var charge = change.charge..id = null;
    var product = charge.product..id = null;
    var group = product.group..id = null;
    var home = change.home;
    var user = change.user;
    user = await userRepository.save(user);
    home = await homeRepository.save(home);
    group = await groupRepository.save(group, user);
    product = await productRepository.save(product, user);
    charge = await chargeRepository.save(charge, user);
    change = await changeRepository.save(change);

    expect(change.id, isNotNull);
    expect(charge.id, isNotNull);
    expect(charge.modelChanges[0].modification, equals(ModelChangeType.create));
    expect(product.id, isNotNull);
    expect(product.modelChanges[0].modification, equals(ModelChangeType.create));
    expect(group.id, isNotNull);
    expect(group.modelChanges[0].modification, equals(ModelChangeType.create));

    user.name = "otherName";
    group.name = "otherName";
    product.description = "otherDescription";
    charge.expirationDate = LocalDate(2000, 1, 1);

    user = await userRepository.save(user);
    charge = await chargeRepository.save(charge, user);
    product = await productRepository.save(product, user);
    charge.product = product;
    group = await groupRepository.save(group, user);
    product.group = group;

    expect(user.name, equals("otherName"));
    expect(group.name, equals("otherName"));
    expect(group.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(group.modelChanges[1].modifications[0].fieldName, equals("name"));
    expect(group.modelChanges[1].modifications[0].from, equals(DEFAULT_GROUP_NAME));
    expect(group.modelChanges[1].modifications[0].to, equals("otherName"));
    expect(group.products[0] == product, isTrue);
    expect(product.description, equals("otherDescription"));
    expect(product.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(product.modelChanges[1].modifications[0].fieldName, equals("description"));
    expect(product.modelChanges[1].modifications[0].from, equals(DEFAULT_PRODUCT_DESCRIPTION));
    expect(product.modelChanges[1].modifications[0].to, equals("otherDescription"));
    expect(product.charges[0] == charge, isTrue);
    expect(charge.expirationDate, equals(LocalDate(2000, 1, 1)));
    expect(charge.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(charge.modelChanges[1].modifications[0].fieldName, equals("expirationDate"));
    expect(charge.modelChanges[1].modifications[0].from, equals("Tuesday, 30 June 2020"));
    expect(charge.modelChanges[1].modifications[0].to, equals("Saturday, 01 January 2000"));

    List<Change> changes = await changeRepository.findAllByChangeDateAfterAndHomeId(LocalDate.today(), DEFAULT_HOME_ID);
    expect(changes.length, equals(0));
    changes = await changeRepository.findAllByChangeDateAfterAndHomeId(LocalDate(2000, 1, 1), DEFAULT_HOME_ID);
    expect(changes.length, equals(1));
    expect(changes[0].charge.expirationDate, equals(LocalDate(2000, 1, 1)));
    expect(changes[0].charge.product.description, equals("otherDescription"));
    expect(changes[0].charge.product.group.name, equals("otherName"));

    List<ModelChange> modelChanges = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDate.today(), DEFAULT_HOME_ID);
    expect(modelChanges.length, equals(0));

    modelChanges = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDate(2000, 1, 1), DEFAULT_MODEL_CHANGE_ID);
    expect(modelChanges.length, equals(6));
  });

  test('Find active home', () async {
    Home home = createDefaultHome();
    await homeRepository.save(home);
    var result = await homeRepository.findOneByActiveTrue();
    expect(result, isNull);

    await homeRepository.save(home, active: true);
    home = await homeRepository.findOneByActiveTrue();
    expect(home, isNotNull);
  });

  test('Find active user', () async {
    User user = createDefaultUser();
    await userRepository.save(user);
    var result = await userRepository.findOneByActiveTrue();
    expect(result, isNull);

    await userRepository.save(user, active: true);
    user = await userRepository.findOneByActiveTrue();
    expect(user, isNotNull);
  });
}
