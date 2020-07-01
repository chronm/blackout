import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/batch_repository.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ChangeRepository changeRepository;
  BatchRepository batchRepository;
  ProductRepository productRepository;
  GroupRepository groupRepository;
  UserRepository userRepository;
  HomeRepository homeRepository;
  ModelChangeRepository modelChangeRepository;

  setUp(() {
    _database = Database.forTesting();
    changeRepository = _database.changeRepository;
    batchRepository = _database.batchRepository;
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
    var batch = change.batch..id = null;
    var product = batch.product..id = null;
    var group = product.group..id = null;
    var home = change.home;
    var user = change.user;
    user = await userRepository.save(user);
    home = await homeRepository.save(home);
    group = await groupRepository.save(group, user);
    product = await productRepository.save(product, user);
    batch = await batchRepository.save(batch, user);
    change = await changeRepository.save(change);

    expect(change.id, isNotNull);
    expect(batch.id, isNotNull);
    expect(batch.modelChanges[0].modification, equals(ModelChangeType.create));
    expect(product.id, isNotNull);
    expect(product.modelChanges[0].modification, equals(ModelChangeType.create));
    expect(group.id, isNotNull);
    expect(group.modelChanges[0].modification, equals(ModelChangeType.create));

    user.name = "otherName";
    group.name = "otherName";
    product.description = "otherDescription";
    batch.expirationDate = LocalDate(2000, 1, 1);

    user = await userRepository.save(user);
    batch = await batchRepository.save(batch, user);
    product = await productRepository.save(product, user);
    batch.product = product;
    group = await groupRepository.save(group, user);
    product.group = group;

    expect(user.name, equals("otherName"));
    expect(group.name, equals("otherName"));
    expect(group.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(group.modelChanges[1].modifications[0].fieldName, equals("name"));
    expect(group.modelChanges[1].modifications[0].from, equals(defaultGroupName));
    expect(group.modelChanges[1].modifications[0].to, equals("otherName"));
    expect(group.products[0] == product, isTrue);
    expect(product.description, equals("otherDescription"));
    expect(product.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(product.modelChanges[1].modifications[0].fieldName, equals("description"));
    expect(product.modelChanges[1].modifications[0].from, equals(defaultProductDescription));
    expect(product.modelChanges[1].modifications[0].to, equals("otherDescription"));
    expect(product.batches[0] == batch, isTrue);
    expect(batch.expirationDate, equals(LocalDate(2000, 1, 1)));
    expect(batch.modelChanges[1].modification, equals(ModelChangeType.modify));
    expect(batch.modelChanges[1].modifications[0].fieldName, equals("expirationDate"));
    expect(batch.modelChanges[1].modifications[0].from, equals("Tuesday, 30 June 2020"));
    expect(batch.modelChanges[1].modifications[0].to, equals("Saturday, 01 January 2000"));

    var changes = await changeRepository.findAllByChangeDateAfterAndHomeId(LocalDate.today(), defaultHomeId);
    expect(changes.length, equals(0));
    changes = await changeRepository.findAllByChangeDateAfterAndHomeId(LocalDate(2000, 1, 1), defaultHomeId);
    expect(changes.length, equals(1));
    expect(changes[0].batch.expirationDate, equals(LocalDate(2000, 1, 1)));
    expect(changes[0].batch.product.description, equals("otherDescription"));
    expect(changes[0].batch.product.group.name, equals("otherName"));

    var modelChanges = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDate.today(), defaultHomeId);
    expect(modelChanges.length, equals(0));

    modelChanges = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDate(2000, 1, 1), defaultModelChangeId);
    expect(modelChanges.length, equals(6));
  });

  test('Find active home', () async {
    var home = createDefaultHome();
    await homeRepository.save(home);
    var result = await homeRepository.findOneByActiveTrue();
    expect(result, isNull);

    await homeRepository.save(home, active: true);
    home = await homeRepository.findOneByActiveTrue();
    expect(home, isNotNull);
  });

  test('Find active user', () async {
    var user = createDefaultUser();
    await userRepository.save(user);
    var result = await userRepository.findOneByActiveTrue();
    expect(result, isNull);

    await userRepository.save(user, active: true);
    user = await userRepository.findOneByActiveTrue();
    expect(user, isNotNull);
  });
}
