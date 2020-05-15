import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/models/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:optional/optional.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting(VmDatabase.memory());
    homeRepository = _database.homeRepository;
  });

  tearDown(() {
    _database.close();
  });

  test('(FindAll) find all homes', () async {
    await homeRepository.save(createDefaultHome());

    List<Home> homes = await homeRepository.findAll();

    expect(homes.length, equals(1));
    expect(homes[0].name, equals(DEFAULT_HOME_NAME));
    expect(homes[0].id, equals(DEFAULT_HOME_ID));
  });

  test('(FindOneById) find optional home by id', () async {
    await homeRepository.save(createDefaultHome());

    Optional<Home> home = await homeRepository.findOneById(DEFAULT_HOME_ID);

    expect(home.isEmpty, isFalse);
  });
}
