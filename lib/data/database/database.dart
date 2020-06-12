import 'dart:io';

import 'package:Blackout/data/database/group_table.dart';
import 'package:Blackout/data/database/change_table.dart';
import 'package:Blackout/data/database/home_table.dart';
import 'package:Blackout/data/database/charge_table.dart';
import 'package:Blackout/data/database/model_change_table.dart';
import 'package:Blackout/data/database/modification_table.dart';
import 'package:Blackout/data/database/product_table.dart';
import 'package:Blackout/data/database/sync_table.dart';
import 'package:Blackout/data/database/user_table.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/modification_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/sync_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

Future<File> getDatabasePath() async {
  Directory directory = Directory(Platform.isAndroid ? p.join((await PathProviderEx.getStorageInfo())[0].rootDir, 'Blackout') : (await getApplicationDocumentsDirectory()).path);
  if (!directory.existsSync()) {
    directory.createSync();
  }
  return File(p.join(directory.path, 'db.sqlite'));
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.

    return VmDatabase(await getDatabasePath());
  });
}

@UseMoor(
    tables: [ChargeTable, ProductTable, GroupTable, ChangeTable, ModelChangeTable, SyncTable, UserTable, HomeTable, ModificationTable],
    daos: [ChargeRepository, ProductRepository, GroupRepository, ChangeRepository, ModelChangeRepository, SyncRepository, UserRepository, HomeRepository, ModificationRepository])
class Database<T> extends _$Database {
  Database() : super(_openConnection());

  Database.forTesting(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;
}
