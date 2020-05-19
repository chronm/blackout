import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ModelChangeRepository modelChangeRepository;
  UserRepository userRepository;
  GroupRepository groupRepository;
  ProductRepository productRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    modelChangeRepository = _database.modelChangeRepository;
    userRepository = _database.userRepository;
    groupRepository = _database.groupRepository;
    productRepository = _database.productRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() {
    _database.close();
  });

  test('(Save) Insert a new databaseChange', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    await groupRepository.save(group, createDefaultUser());
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, group: group);
    await userRepository.save(changelog.user);

    changelog = await modelChangeRepository.save(changelog);

    expect(changelog.id, isNotNull);
  });

  test('(FindAllByModificationDateAfter) Get one change if modificationDate after now', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    User user = await userRepository.save(createDefaultUser());
    await groupRepository.save(group, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDateTime(2000, 1, 1, 0, 0, 0), DEFAULT_HOME_ID);

    expect(changes.length, equals(1));
  });

  test('(FindAllByModificationDateAfter) Get zero if modificationDate before now', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    User user = await userRepository.save(createDefaultUser());
    await groupRepository.save(group, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDateTime(2999, 12, 31, 0, 0, 0), DEFAULT_HOME_ID);

    expect(changes.length, equals(0));
  });

  test('(FindAll) Find all databaseChangelogs', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    User user = await userRepository.save(createDefaultUser());
    await groupRepository.save(group, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByHomeId(DEFAULT_HOME_ID);

    expect(changes.length, equals(1));
  });

  test('(FindAllByGroupIdAndHomeId', () async {
    Group group = createDefaultGroup();
    await homeRepository.save(group.home);
    User user = await userRepository.save(createDefaultUser());
    await groupRepository.save(group, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByGroupIdAndHomeId(group.id, group.home.id);

    expect(changes.length, equals(1));
  });

  test('(FindAllByProductIdAndHomeId)', () async {
    Product product = createDefaultProduct();
    await homeRepository.save(product.home);
    User user = await userRepository.save(createDefaultUser());
    await productRepository.save(product, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByProductIdAndHomeId(product.id, product.home.id);

    expect(changes.length, equals(1));
  });
}
