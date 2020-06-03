import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional_internal.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  UserRepository userRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    userRepository = _database.userRepository;
  });

  tearDown(() async {
    await _database.close();
  });

  test('(Save) Insert a new user', () async {
    User user = createDefaultUser();

    user = await userRepository.save(user);

    expect(user.id, isNotNull);
    expect(user.name, equals(DEFAULT_USER_NAME));
  });

  test('(GetOneById) Get a user by id', () async {
    User user = createDefaultUser();
    user = await userRepository.save(user);

    user = await userRepository.findOneByUserId(user.id);

    expect(user.id, isNotNull);
    expect(user.name, equals(DEFAULT_USER_NAME));
  });

  test('(GetOneById) Return null if user not found', () async {
    User user = await userRepository.findOneByUserId("");

    expect(user, isNull);
  });

  test('(FindOneById) Optional is present if product found', () async {
    User user = createDefaultUser();
    user = await userRepository.save(user);

    Optional<User> optionalUser = await userRepository.findOneByUserId(user.id);

    expect(optionalUser.isEmpty, isFalse);
  });

  test('(FindOneById) Optional is empty if product not found)', () async {
    Optional<User> optionalUser = await userRepository.findOneByUserId("");

    expect(optionalUser.isEmpty, isTrue);
  });
}
