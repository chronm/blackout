import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../repository/change_repository.dart';
import '../repository/charge_repository.dart';
import '../repository/group_repository.dart';
import '../repository/home_repository.dart';
import '../repository/model_change_repository.dart';
import '../repository/modification_repository.dart';
import '../repository/product_repository.dart';
import '../repository/user_repository.dart';
import 'change_table.dart';
import 'charge_table.dart';
import 'group_table.dart';
import 'home_table.dart';
import 'model_change_table.dart';
import 'modification_table.dart';
import 'product_table.dart';
import 'user_table.dart';

part 'database.g.dart';

Future<File> getDatabasePath() async {
  var directory = Directory(Platform.isAndroid ? p.join('/storage/emulated/0/Blackout') : (await getApplicationDocumentsDirectory()).path);
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
    tables: [ChargeTable, ProductTable, GroupTable, ChangeTable, ModelChangeTable, UserTable, HomeTable, ModificationTable],
    daos: [ChargeRepository, ProductRepository, GroupRepository, ChangeRepository, ModelChangeRepository, UserRepository, HomeRepository, ModificationRepository])
class Database<T> extends _$Database {
  Database() : super(_openConnection());

  Database.forTesting() : super(VmDatabase.memory());

  @override
  int get schemaVersion => 1;
}
