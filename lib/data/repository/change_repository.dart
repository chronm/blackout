import 'package:Blackout/data/database/change_table.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'change_repository.g.dart';

@UseDao(tables: [ChangeTable])
class ChangeRepository extends DatabaseAccessor<Database> with _$ChangeRepositoryMixin {
  ChangeRepository(Database db) : super(db);

  Future<Change> createChange(ChangeEntry changeEntry, {bool recurseCharge = true}) async {
    Change change;

    Charge charge;
    if (recurseCharge) {
      charge = await db.chargeRepository.findOneByChargeId(changeEntry.chargeId, recurseChanges: false);
    }

    User user = await db.userRepository.findOneByUserId(changeEntry.userId);

    Home home = await db.homeRepository.findHomeById(changeEntry.homeId);

    change = Change.fromEntry(changeEntry, user, home, charge: charge);

    if (recurseCharge && change.charge != null) {
      change.charge.changes = [change];
    }

    return change;
  }

  Future<List<Change>> findAllByHomeId(String homeId) async {
    List<ChangeEntry> entries = await (select(changeTable)..where((c) => c.homeId.equals(homeId))).get();

    List<Change> changes = [];
    for (ChangeEntry entry in entries) {
      changes.add(await createChange(entry));
    }

    return changes;
  }

  Future<List<Change>> findAllByChangeDateAfterAndHomeId(LocalDate changeDate, String homeId) async {
    var query = select(changeTable)..where((c) => c.changeDate.isBiggerThanValue(changeDate.toDateTimeUnspecified()) & c.homeId.equals(homeId));
    List<String> ids = await query.map((c) => c.id).get();

    List<Change> changes = [];
    for (String id in ids) {
      changes.add(await findOneByChangeId(id));
    }

    return changes;
  }

  Future<Change> findOneByChangeId(String changeId, {bool recurseCharge = true}) async {
    var query = select(changeTable)..where((c) => c.id.equals(changeId));
    ChangeEntry changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    return createChange(changeEntry, recurseCharge: recurseCharge);
  }

  Future<List<Change>> findAllByChargeId(String chargeId, {bool recurseCharge = true}) async {
    List<Change> changes = [];

    Charge charge;
    if (recurseCharge) {
      charge = await db.chargeRepository.findOneByChargeId(chargeId, recurseProduct: false, recurseChanges: false);
    }

    var query = select(changeTable)..where((c) => c.chargeId.equals(chargeId));
    var result = await query.get();
    for (ChangeEntry changeEntry in result) {
      Change change = await createChange(changeEntry, recurseCharge: false);
      change.charge = charge;
      changes.add(change);
    }

    if (recurseCharge) {
      charge.changes = changes;
    }

    return changes;
  }

  Future<Change> save(Change change) async {
    change.id ??= Uuid().v4();

    await into(changeTable).insertOnConflictUpdate(change.toCompanion());

    return findOneByChangeId(change.id);
  }

  Future<int> drop(Change change, User user) async {
    assert(change.id != null, "Change is no database object");

    return await (delete(changeTable)..where((c) => c.id.equals(change.id))).go();
  }
}
