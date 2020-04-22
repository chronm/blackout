import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ModelChangeRepository modelChangeRepository;
  UserRepository userRepository;
  CategoryRepository categoryRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting();
    modelChangeRepository = _database.modelChangeRepository;
    userRepository = _database.userRepository;
    categoryRepository = _database.categoryRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() {
    _database.close();
  });

  test('(Save) Insert a new databaseChange', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    await categoryRepository.save(category, createDefaultUser());
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, category: category);
    await userRepository.save(changelog.user);

    changelog = await modelChangeRepository.save(changelog);

    expect(changelog.id, isNotNull);
  });

  test('(FindAllByModificationDateAfter) Get one change if modificationDate after now', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    User user = await userRepository.save(createDefaultUser());
    await categoryRepository.save(category, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDateTime(2000, 1, 1, 0, 0, 0), DEFAULT_HOME_ID);

    expect(changes.length, equals(1));
  });

  test('(FindAllByModificationDateAfter) Get zero if modificationDate before now', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    User user = await userRepository.save(createDefaultUser());
    await categoryRepository.save(category, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByModificationDateAfterAndHomeId(LocalDateTime(2999, 12, 31, 0, 0, 0), DEFAULT_HOME_ID);

    expect(changes.length, equals(0));
  });

  test('(FindAll) Find all databaseChangelogs', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    User user = await userRepository.save(createDefaultUser());
    await categoryRepository.save(category, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByHomeId(DEFAULT_HOME_ID);

    expect(changes.length, equals(1));
  });

  test('(FindAllByCategoryIdAndHomeId', () async {
    Category category = createDefaultCategory();
    await homeRepository.save(category.home);
    User user = await userRepository.save(createDefaultUser());
    await categoryRepository.save(category, user);

    List<ModelChange> changes = await modelChangeRepository.findAllByCategoryIdAndHomeId(category.id, category.home.id);

    expect(changes.length, equals(1));
  });
}
