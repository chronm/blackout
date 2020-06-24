import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/model_change.dart';
import '../database/database.dart';
import '../database/model_change_table.dart';

part 'model_change_repository.g.dart';

@UseDao(tables: [ModelChangeTable])
class ModelChangeRepository extends DatabaseAccessor<Database>
    with _$ModelChangeRepositoryMixin {
  ModelChangeRepository(Database db) : super(db);

  Future<List<ModelChange>> findAllByGroupId(String groupId) async {
    var query = select(modelChangeTable)
      ..where((c) => c.groupId.equals(groupId));
    var entries = await query.get();

    var changes = <ModelChange>[];
    for (var entry in entries) {
      var user = await db.userRepository.findOneByUserId(entry.userId);
      var modifications =
          await db.modificationRepository.findAllByModelChangeId(entry.id);
      var home = await db.homeRepository.findOneById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByProductId(String productId) async {
    var query = select(modelChangeTable)
      ..where((c) => c.productId.equals(productId));
    var entries = await query.get();

    var changes = <ModelChange>[];
    for (var entry in entries) {
      var user = await db.userRepository.findOneByUserId(entry.userId);
      var modifications =
          await db.modificationRepository.findAllByModelChangeId(entry.id);
      var home = await db.homeRepository.findOneById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByChargeId(String chargeId) async {
    var query = select(modelChangeTable)
      ..where((c) => c.chargeId.equals(chargeId));
    var entries = await query.get();

    var changes = <ModelChange>[];
    for (var entry in entries) {
      var user = await db.userRepository.findOneByUserId(entry.userId);
      var modifications =
          await db.modificationRepository.findAllByModelChangeId(entry.id);
      var home = await db.homeRepository.findOneById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByModificationDateAfterAndHomeId(
      LocalDate modificationDate, String homeId) async {
    var query = select(modelChangeTable)
      ..where((c) => c.modificationDate
          .isBiggerThanValue(modificationDate.toDateTimeUnspecified()));
    var entries = await query.get();

    var changes = <ModelChange>[];
    for (var entry in entries) {
      var user = await db.userRepository.findOneByUserId(entry.userId);
      var modifications =
          await db.modificationRepository.findAllByModelChangeId(entry.id);
      var home = await db.homeRepository.findOneById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<ModelChange> findOneByChangeId(String changeId) async {
    var query = select(modelChangeTable)..where((c) => c.id.equals(changeId));
    var changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    var user = await db.userRepository.findOneByUserId(changeEntry.userId);

    var modifications =
        await db.modificationRepository.findAllByModelChangeId(changeEntry.id);

    var home = await db.homeRepository.findOneById(changeEntry.homeId);
    return ModelChange.fromEntry(changeEntry, user, home, modifications);
  }

  Future<ModelChange> save(ModelChange change) async {
    change.id ??= Uuid().v4();

    await into(modelChangeTable).insertOnConflictUpdate(change.toCompanion());

    return findOneByChangeId(change.id);
  }
}
