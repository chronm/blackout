import 'package:moor/moor.dart';

@DataClassName("UserEntry")
class UserTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  BoolColumn get active => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
