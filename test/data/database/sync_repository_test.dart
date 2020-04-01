import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/sync.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  SyncRepository syncRepository;
  UserRepository userRepository;
  HomeRepository homeRepository;

  setUp(() {
    _database = Database.forTesting();
    syncRepository = _database.syncRepository;
    userRepository = _database.userRepository;
    homeRepository = _database.homeRepository;
  });

  tearDown(() {
    _database.close();
  });

  test('', () async {
    Sync sync = createDefaultSync();
    await homeRepository.save(sync.home);
    await userRepository.save(sync.user);
    await syncRepository.save(sync);

    List<Sync> syncs = await syncRepository.findAllByHomeId(DEFAULT_HOME_ID);

    expect(syncs.length, equals(1));
  });
}
