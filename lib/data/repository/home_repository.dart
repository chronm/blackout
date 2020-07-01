import 'package:moor/moor.dart';

import '../../models/home.dart';
import '../database/database.dart';
import '../database/home_table.dart';

part 'home_repository.g.dart';

@UseDao(tables: [HomeTable])
class HomeRepository extends DatabaseAccessor<Database> with _$HomeRepositoryMixin {
  HomeRepository(Database attachedDatabase) : super(attachedDatabase);

  Future<List<Home>> findAll() async {
    return (await select(homeTable).get()).map((h) => Home.fromEntry(h)).toList();
  }

  Future<Home> findOneByActiveTrue() async {
    var query = select(homeTable)..where((h) => h.active);
    var entry = await query.getSingle();
    if (entry == null) return null;
    return Home.fromEntry(entry);
  }

  Future<Home> findOneById(String homeId) async {
    var query = select(homeTable)..where((h) => h.id.equals(homeId));
    var entry = await query.getSingle();
    return Home.fromEntry(entry);
  }

  Future<Home> save(Home home, {bool active = false}) async {
    await into(homeTable).insert(home.toCompanion(active: active), mode: InsertMode.replace);

    return home;
  }
}
