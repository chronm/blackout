import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/repository/modification_repository.dart';
import 'package:Blackout/models/modification.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  Database _database;
  ModificationRepository modificationRepository;

  setUp(() {
    _database = Database.forTesting();
    modificationRepository = _database.modificationRepository;
  });

  test('description', () async {
    Modification modification = createDefaultModification();
    await modificationRepository.save(modification);

    List<Modification> modifications = await modificationRepository.findAllByModelChangeIdAndHomeId(DEFAULT_MODEL_CHANGE_ID, DEFAULT_HOME_ID);

    expect(modifications.length, equals(1));
  });
}
