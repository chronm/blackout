import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/user_table.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional.dart';
import 'package:uuid/uuid.dart';

part 'user_repository.g.dart';

@UseDao(tables: [UserTable])
class UserRepository extends DatabaseAccessor<Database> with _$UserRepositoryMixin {
  UserRepository(Database db) : super(db);

  Future<Optional<User>> findOneByUserId(String userId) async {
    return Optional.ofNullable(await getOneByUserId(userId));
  }

  Future<User> getOneByUserId(String userId) async {
    var query = select(userTable)..where((u) => u.id.equals(userId));
    UserEntry userEntry = await query.getSingle();
    if (userEntry == null) return null;

    return User.fromEntry(userEntry);
  }

  Future<User> save(User user) async {
    user.id ??= Uuid().v4();

    await into(userTable).insert(user.toCompanion(), mode: InsertMode.insertOrReplace);

    return await getOneByUserId(user.id);
  }
}
