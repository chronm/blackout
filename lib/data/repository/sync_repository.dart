import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/sync_table.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/sync.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';

part 'sync_repository.g.dart';

@UseDao(tables: [SyncTable])
class SyncRepository extends DatabaseAccessor<Database> with _$SyncRepositoryMixin {
  SyncRepository(Database db) : super(db);

  Future<List<Sync>> findAllByHomeId(String homeId) async {
    List<SyncEntry> entries = await (select(syncTable)..where((s) => s.homeId.equals(homeId))).get();

    List<Sync> syncs = [];
    for (SyncEntry entry in entries) {
      User user = await db.userRepository.getOneByUserId(entry.userId);
      Home home = await db.homeRepository.getHomeById(entry.homeId);
      Sync sync = Sync.fromEntry(entry, user, home);
      syncs.add(sync);
    }

    return syncs;
  }

  Future<Sync> save(Sync sync) async {
    await into(syncTable).insert(sync.toCompanion(), mode: InsertMode.insertOrReplace);

    return sync;
  }
}
