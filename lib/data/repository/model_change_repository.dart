import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/model_change_table.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'model_change_repository.g.dart';

@UseDao(tables: [ModelChangeTable])
class ModelChangeRepository extends DatabaseAccessor<Database> with _$ModelChangeRepositoryMixin {
  ModelChangeRepository(Database db) : super(db);

  Future<List<ModelChange>> findAllByHomeId(String homeId) async {
    List<ModelChangeEntry> entries = await (select(modelChangeTable)..where((c) => c.homeId.equals(homeId))).get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.findOneByUserId(entry.userId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(entry.id);
      Home home = await db.homeRepository.findHomeById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByGroupId(String groupId) async {
    var query = select(modelChangeTable)..where((c) => c.groupId.equals(groupId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.findOneByUserId(entry.userId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(entry.id);
      Home home = await db.homeRepository.findHomeById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByProductId(String productId) async {
    var query = select(modelChangeTable)..where((c) => c.productId.equals(productId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.findOneByUserId(entry.userId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(entry.id);
      Home home = await db.homeRepository.findHomeById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByChargeId(String chargeId) async {
    var query = select(modelChangeTable)..where((c) => c.chargeId.equals(chargeId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.findOneByUserId(entry.userId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(entry.id);
      Home home = await db.homeRepository.findHomeById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByModificationDateAfterAndHomeId(LocalDate modificationDate, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.modificationDate.isBiggerThanValue(modificationDate.toDateTimeUnspecified()));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.findOneByUserId(entry.userId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(entry.id);
      Home home = await db.homeRepository.findHomeById(entry.homeId);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<ModelChange> findOneByChangeId(String changeId) async {
    var query = select(modelChangeTable)..where((c) => c.id.equals(changeId));
    ModelChangeEntry changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    User user = await db.userRepository.findOneByUserId(changeEntry.userId);

    List<Modification> modifications = await db.modificationRepository.findAllByModelChangeId(changeEntry.id);

    Home home = await db.homeRepository.findHomeById(changeEntry.homeId);
    return ModelChange.fromEntry(changeEntry, user, home, modifications);
  }

  Future<ModelChange> save(ModelChange change) async {
    change.id ??= Uuid().v4();

    await into(modelChangeTable).insertOnConflictUpdate(change.toCompanion());

    return findOneByChangeId(change.id);
  }
}
