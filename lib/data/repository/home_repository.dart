import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/home_table.dart';
import 'package:Blackout/models/home.dart';
import 'package:moor/moor.dart';

part 'home_repository.g.dart';

@UseDao(tables: [HomeTable])
class HomeRepository extends DatabaseAccessor<Database> with _$HomeRepositoryMixin {
  HomeRepository(Database db) : super(db);

  Future<List<Home>> findAll() async {
    return (await select(homeTable).get()).map((h) => Home.fromEntry(h)).toList();
  }

  Future<Home> findHomeByActiveTrue() async {
    var query = select(homeTable)..where((h) => h.active);
    HomeEntry entry = await query.getSingle();
    return Home.fromEntry(entry);
  }

  Future<Home> findHomeById(String homeId) async {
    var query = select(homeTable)..where((h) => h.id.equals(homeId));
    HomeEntry entry = await query.getSingle();
    return Home.fromEntry(entry);
  }

  Future<Home> save(Home home, {bool active = false}) async {
    await into(homeTable).insert(home.toCompanion(active: active));

    return home;
  }
}
