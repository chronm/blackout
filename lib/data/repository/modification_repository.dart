import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/modification_table.dart';
import 'package:Blackout/models/modification.dart';
import 'package:moor/moor.dart';

part 'modification_repository.g.dart';

@UseDao(tables: [ModificationTable])
class ModificationRepository extends DatabaseAccessor<Database> with _$ModificationRepositoryMixin {
  ModificationRepository(Database db) : super(db);

  Future<List<Modification>> findAllByModelChangeId(String modelChangeId) async {
    var query = select(modificationTable)..where((m) => m.modelChangeId.equals(modelChangeId));
    List<ModificationEntry> entries = (await query.get());
    return entries.map((m) => Modification.fromEntry(m)).toList();
  }

  void save(Modification modification) async {
    await into(modificationTable).insert(modification.toCompanion());
  }
}
