import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/home_table.dart';
import 'package:Blackout/models/home.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional.dart';

part 'home_repository.g.dart';

@UseDao(tables: [HomeTable])
class HomeRepository extends DatabaseAccessor<Database> with _$HomeRepositoryMixin {
  HomeRepository(Database db) : super(db);

  Future<List<Home>> findAll() async {
    return (await select(homeTable).get()).map((h) => Home.fromEntry(h)).toList();
  }

  Future<Optional<Home>> findOneById(String homeId) async {
    return Optional.ofNullable(await getHomeById(homeId));
  }

  Future<Home> getHomeById(String homeId) async {
    var query = select(homeTable)..where((h) => h.id.equals(homeId));
    HomeEntry entry = await query.getSingle();
    return Home.fromEntry(entry);
  }

  Future<Home> save(Home home) async {
    await into(homeTable).insert(home.toCompanion(), mode: InsertMode.insertOrReplace);

    return home;
  }
}
