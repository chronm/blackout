import 'package:moor/moor.dart' show DatabaseAccessor, InsertMode, UseDao;
// ignore: implementation_imports
import 'package:moor/src/runtime/query_builder/query_builder.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/batch.dart';
import '../../models/change.dart';
import '../../models/user.dart';
import '../database/change_table.dart';
import '../database/database.dart';

part 'change_repository.g.dart';

@UseDao(tables: [ChangeTable])
class ChangeRepository extends DatabaseAccessor<Database> with _$ChangeRepositoryMixin {
  ChangeRepository(Database attachedDatabase) : super(attachedDatabase);

  Future<Change> createChange(ChangeEntry changeEntry, {bool recurseBatch = true}) async {
    Change change;

    Batch batch;
    if (recurseBatch) {
      batch = await attachedDatabase.batchRepository.findOneByBatchId(changeEntry.batchId, recurseChanges: false);
    }

    var user = await attachedDatabase.userRepository.findOneByUserId(changeEntry.userId);

    var home = await attachedDatabase.homeRepository.findOneById(changeEntry.homeId);

    change = Change.fromEntry(changeEntry, user, home, batch: batch);

    if (recurseBatch && change.batch != null) {
      change.batch.changes = [change];
    }

    return change;
  }

  Future<List<Change>> findAllByChangeDateAfterAndHomeId(LocalDate changeDate, String homeId) async {
    var query = select(changeTable)..where((c) => c.changeDate.isBiggerThanValue(changeDate.toDateTimeUnspecified()) & c.homeId.equals(homeId));
    var ids = await query.map((c) => c.id).get();

    var changes = <Change>[];
    for (var id in ids) {
      changes.add(await findOneByChangeId(id));
    }

    return changes;
  }

  Future<Change> findOneByChangeId(String changeId, {bool recurseBatch = true}) async {
    var query = select(changeTable)..where((c) => c.id.equals(changeId));
    var changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    return createChange(changeEntry, recurseBatch: recurseBatch);
  }

  Future<List<Change>> findAllByBatchId(String batchId, {bool recurseBatch = true}) async {
    var changes = <Change>[];

    Batch batch;
    if (recurseBatch) {
      batch = await attachedDatabase.batchRepository.findOneByBatchId(batchId, recurseProduct: false, recurseChanges: false);
    }

    var query = select(changeTable)..where((c) => c.batchId.equals(batchId));
    var result = await query.get();
    for (var changeEntry in result) {
      var change = await createChange(changeEntry, recurseBatch: false);
      change.batch = batch;
      changes.add(change);
    }

    if (recurseBatch) {
      batch.changes = changes;
    }

    return changes;
  }

  Future<Change> save(Change change) async {
    change.id ??= Uuid().v4();

    await into(changeTable).insert(change.toCompanion(), mode: InsertMode.replace);

    return findOneByChangeId(change.id);
  }

  Future<int> drop(Change change, User user) async {
    assert(change.id != null, "Change is no database object");

    return await (delete(changeTable)..where((c) => c.id.equals(change.id))).go();
  }
}
