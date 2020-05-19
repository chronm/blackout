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
    List<ModelChangeEntry> entries = await (select(modelChangeTable)..where((d) => d.homeId.equals(homeId))).get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(entry.id, home.id);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByGroupIdAndHomeId(String groupId, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.groupId.equals(groupId) & c.homeId.equals(homeId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(entry.id, home.id);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByProductIdAndHomeId(String productId, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.productId.equals(productId) & c.homeId.equals(homeId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(entry.id, home.id);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByChargeIdAndHomeId(String chargeId, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.chargeId.equals(chargeId) & c.homeId.equals(homeId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(entry.id, home.id);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<List<ModelChange>> findAllByModificationDateAfterAndHomeId(LocalDateTime modificationDate, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.modificationDate.isBiggerThanValue(modificationDate.toDateTimeLocal()) & c.homeId.equals(homeId));
    List<ModelChangeEntry> entries = await query.get();

    List<ModelChange> changes = [];
    for (ModelChangeEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(entry.id, home.id);
      changes.add(ModelChange.fromEntry(entry, user, home, modifications));
    }

    return changes;
  }

  Future<ModelChange> getOneByChangeIdHomeId(String changeId, String homeId) async {
    var query = select(modelChangeTable)..where((c) => c.id.equals(changeId))..where((c) => c.homeId.equals(homeId));
    ModelChangeEntry changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    User user = await db.userRepository.getOneByUserId(changeEntry.userId);

    Home home = await db.homeRepository.getHomeById(changeEntry.homeId);

    List<Modification> modifications = await db.modificationRepository.findAllByModelChangeIdAndHomeId(changeEntry.id, home.id);

    return ModelChange.fromEntry(changeEntry, user, home, modifications);
  }

  Future<ModelChange> save(ModelChange change) async {
    change.id ??= Uuid().v4();

    await into(modelChangeTable).insertOnConflictUpdate(change.toCompanion());

    return getOneByChangeIdHomeId(change.id, change.home.id);
  }
}
