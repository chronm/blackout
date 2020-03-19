import 'package:Blackout/data/database/change_table.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional_internal.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'change_repository.g.dart';

@UseDao(tables: [ChangeTable])
class ChangeRepository extends DatabaseAccessor<Database> with _$ChangeRepositoryMixin {
  ChangeRepository(Database db) : super(db);

  Future<Change> createChange(ChangeEntry changeEntry, {bool recurseItem = true}) async {
    Change change;

    Item item;
    if (recurseItem) {
      item = await db.itemRepository.getOneByItemIdAndHomeId(changeEntry.itemId, changeEntry.homeId, recurseChanges: false);
    }

    User user = await db.userRepository.getOneByUserId(changeEntry.userId);

    Home home = await db.homeRepository.getHomeById(changeEntry.homeId);

    change = Change.fromEntry(changeEntry, user, home, item: item);

    if (recurseItem && change.item != null) {
      change.item.changes = [change];
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

  Future<List<Change>> findAllByChangeDateAfterAndHomeId(LocalDateTime changeDate, String homeId) async {
    var query = select(db.changeTable)..where((c) => c.changeDate.isBiggerThanValue(changeDate.toDateTimeLocal()))..where((c) => c.homeId.equals(homeId));
    List<String> ids = await query.map((c) => c.id).get();

    List<Change> changes = [];
    for (String id in ids) {
      changes.add(await getOneByChangeIdAndHomeId(id, homeId));
    }

    return changes;
  }

  Future<Optional<Change>> findOneByChangeIdAndHomeId(String changeId, String homeId, {bool recurseItem = true}) async {
    return Optional.ofNullable(await getOneByChangeIdAndHomeId(changeId, homeId, recurseItem: recurseItem));
  }

  Future<Change> getOneByChangeIdAndHomeId(String changeId, String homeId, {bool recurseItem = true}) async {

    var query = select(changeTable)..where((c) => c.id.equals(changeId));
    ChangeEntry changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    return createChange(changeEntry, recurseItem: recurseItem);
  }

  Future<List<Change>> getAllByItemIdAndHomeId(String itemId, String homeId, {bool recurseItem = true}) async {
    List<Change> changes = [];

    Item item;
    if (recurseItem) {
      item = await db.itemRepository.getOneByItemIdAndHomeId(itemId, homeId, recurseProduct: false, recurseChanges: false);
    }

    var query = select(changeTable)..where((c) => c.itemId.equals(itemId));
    var result = await query.get();
    for (ChangeEntry changeEntry in result) {
      Change change = await createChange(changeEntry, recurseItem: false);
      change.item = item;
      changes.add(change);
    }

    if (recurseItem) {
      item.changes = changes;
    }

    return changes;
  }

  Future<Change> save(Change change) async {
    change.id ??= Uuid().v4();

    await into(changeTable).insert(change.toCompanion(), mode: InsertMode.insertOrReplace);

    return getOneByChangeIdAndHomeId(change.id, change.home.id);
  }

  Future<int> drop(Change change) async {
    assert(change.id != null, "Change is no database object");

    return await (delete(changeTable)..where((c) => c.id.equals(change.id))).go();
  }
}
