import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

import '../../models/user.dart';
import '../database/database.dart';
import '../database/user_table.dart';

part 'user_repository.g.dart';

@UseDao(tables: [UserTable])
class UserRepository extends DatabaseAccessor<Database> with _$UserRepositoryMixin {
  UserRepository(Database db) : super(db);

  Future<User> findOneByActiveTrue() async {
    var query = select(userTable)..where((u) => u.active);
    var entry = await query.getSingle();
    if (entry == null) return null;
    return User.fromEntry(entry);
  }

  Future<User> findOneByUserId(String userId) async {
    var query = select(userTable)..where((u) => u.id.equals(userId));
    var userEntry = await query.getSingle();
    if (userEntry == null) return null;

    return User.fromEntry(userEntry);
  }

  Future<User> save(User user, {bool active = false}) async {
    user.id ??= Uuid().v4();

    await into(userTable).insertOnConflictUpdate(user.toCompanion(active: active));

    return await findOneByUserId(user.id);
  }
}
