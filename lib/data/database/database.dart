import 'dart:io';

import 'package:Blackout/data/database/category_table.dart';
import 'package:Blackout/data/database/change_table.dart';
import 'package:Blackout/data/database/database_changelog_table.dart';
import 'package:Blackout/data/database/home_table.dart';
import 'package:Blackout/data/database/item_table.dart';
import 'package:Blackout/data/database/product_table.dart';
import 'package:Blackout/data/database/sync_table.dart';
import 'package:Blackout/data/database/user_table.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/database_changelog_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [ItemTable, ProductTable, CategoryTable, ChangeTable, DatabaseChangelogTable, SyncTable, UserTable, HomeTable], daos: [ItemRepository, ProductRepository, CategoryRepository, ChangeRepository, DatabaseChangelogRepository, SyncRepository, UserRepository, HomeRepository])
class Database<T> extends _$Database {
  Database() : super(_openConnection());

  Database.forTesting() : super(VmDatabase.memory());

  @override
  int get schemaVersion => 1;
}
