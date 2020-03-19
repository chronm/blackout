import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/database_changelog_table.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'database_changelog_repository.g.dart';

@UseDao(tables: [DatabaseChangelogTable])
class DatabaseChangelogRepository extends DatabaseAccessor<Database> with _$DatabaseChangelogRepositoryMixin {
  DatabaseChangelogRepository(Database db) : super(db);

  Future<List<DatabaseChangelog>> findAllByHomeId(String homeId) async {
    List<DatabaseChangelogEntry> entries = await (select(databaseChangelogTable)..where((d) => d.homeId.equals(homeId))).get();

    List<DatabaseChangelog> changes = [];
    for (DatabaseChangelogEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      changes.add(DatabaseChangelog.fromEntry(entry, user, home));
    }

    return changes;
  }

  Future<List<DatabaseChangelog>> findAllByModificationDateAfterAndHomeId(LocalDateTime modificationDate, String homeId) async {
    var query = select(databaseChangelogTable)..where((c) => c.modificationDate.isBiggerThanValue(modificationDate.toDateTimeLocal()))..where((c) => c.homeId.equals(homeId));
    List<DatabaseChangelogEntry> entries = await query.get();

    List<DatabaseChangelog> changes = [];
    for (DatabaseChangelogEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      changes.add(DatabaseChangelog.fromEntry(entry, user, home));
    }

    return changes;
  }

  Future<DatabaseChangelog> getOneByChangeIdHomeId(String changeId, String homeId) async {
    var query = select(databaseChangelogTable)..where((c) => c.id.equals(changeId))..where((c) => c.homeId.equals(homeId));
    DatabaseChangelogEntry changeEntry = (await query.getSingle());
    if (changeEntry == null) return null;

    User user = await db.userRepository.getOneByUserId(changeEntry.userId);

    Home home = await db.homeRepository.getHomeById(changeEntry.homeId);

    return DatabaseChangelog.fromEntry(changeEntry, user, home);
  }

  Future<DatabaseChangelog> save(DatabaseChangelog change) async {
    change.id ??= Uuid().v4();

    await into(databaseChangelogTable).insert(change.toCompanion(), mode: InsertMode.insertOrReplace);

    return getOneByChangeIdHomeId(change.id, change.home.id);
  }
}
