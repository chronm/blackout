import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ProductRepository productRepository;
  GroupRepository groupRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    productRepository = _database.productRepository;
    groupRepository = _database.groupRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new group', () async {
    Group group = createDefaultGroup();
    User user = createDefaultUser();

    await homeRepository.save(group.home);
    group = await groupRepository.save(group, user);

    expect(group.id, isNotNull);
    expect(group.name, equals(DEFAULT_CATEGORY_NAME));
    expect(group.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(group.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
  });

  test('(Save) Update a group', () async {
    Group group = createDefaultGroup();
    User user = createDefaultUser();
    await homeRepository.save(group.home);
    group = await groupRepository.save(group, user);
    String groupId = group.id;

    group.name = "test";
    await groupRepository.save(group, user);
    group = await groupRepository.findOneByGroupId(groupId, DEFAULT_HOME_ID);

    expect(group.id, equals(groupId));
    expect(group.name, equals("test"));
    expect(group.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(group.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(group.home.name, equals(DEFAULT_HOME_NAME));
    expect(group.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(Drop) Throw exception if group to drop is no database object', () async {
    await groupRepository.findAllByHomeId(DEFAULT_HOME_ID);
    Group group = createDefaultGroup();
    expect(() => groupRepository.drop(group), throwsAssertionError);
  });

  test('(Drop) Delete a group', () async {
    Group group = createDefaultGroup();

    await homeRepository.save(group.home);
    User user = createDefaultUser();
    group = await groupRepository.save(group, user);

    var result = await groupRepository.drop(group);
    expect(result, equals(1));

    List<Group> groups = await groupRepository.findAllByHomeId(DEFAULT_HOME_ID);
    expect(groups.length, equals(0));
    expect(group.home.name, equals(DEFAULT_HOME_NAME));
    expect(group.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByGroupId) Group contains Syncs if recurseSyncs=true', () async {
    User user = createDefaultUser();
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    product.group = group;

    await homeRepository.save(group.home);
    group = await groupRepository.save(group, user);
    product = await productRepository.save(product, user);

    group = await groupRepository.findOneByGroupId(group.id, DEFAULT_HOME_ID);
    expect(group.id, isNotNull);
    expect(group.name, equals(DEFAULT_CATEGORY_NAME));
    expect(group.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(group.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(group.products, hasLength(1));
    expect(group.products[0].group.id, equals(group.id));
    expect(group.home.name, equals(DEFAULT_HOME_NAME));
    expect(group.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByGroupId) Group does not contain products if recurseProducts=false', () async {
    User user = createDefaultUser();
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    product.group = group;

    await homeRepository.save(group.home);
    group = await groupRepository.save(group, user);
    product = await productRepository.save(product, user);

    group = await groupRepository.findOneByGroupId(group.id, DEFAULT_HOME_ID, recurseProducts: false);
    expect(group.id, isNotNull);
    expect(group.name, equals(DEFAULT_CATEGORY_NAME));
    expect(group.pluralName, equals(DEFAULT_CATEGORY_PLURAL_NAME));
    expect(group.warnInterval, equals(DEFAULT_CATEGORY_WARN_INTERVAL));
    expect(group.products, hasLength(0));
    expect(group.home.name, equals(DEFAULT_HOME_NAME));
    expect(group.home.id, equals(DEFAULT_HOME_ID));
  });

  test('(GetOneByGroupId) Return null if group not found', () async {
    Group group = await groupRepository.findOneByGroupId("", DEFAULT_HOME_ID);

    expect(group, isNull);
  });

  test('(FindOneByGroupId) Optional is empty if group not found', () async {
    Optional<Group> group = await groupRepository.findOneByGroupId("", DEFAULT_HOME_ID);

    expect(group.isEmpty, isTrue);
  });

  test('(FindOneByGroupId) Optional is present if group found)', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    group = await groupRepository.save(group, createDefaultUser());

    Optional<Group> optionalGroup = await groupRepository.findOneByGroupId(group.id, DEFAULT_HOME_ID);

    expect(optionalGroup.isEmpty, isFalse);
  });

  test('(FindAll) find all groups', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    await groupRepository.save(group, createDefaultUser());

    List<Group> groups = await groupRepository.findAllByHomeId(DEFAULT_HOME_ID, recurseProducts: false);
    expect(groups.length, equals(1));
  });
}
