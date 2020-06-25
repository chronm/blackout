import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/group.dart';
import '../../models/model_change.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../database/database.dart';
import '../database/group_table.dart';

part 'group_repository.g.dart';

@UseDao(tables: [GroupTable])
class GroupRepository extends DatabaseAccessor<Database> with _$GroupRepositoryMixin {
  GroupRepository(Database db) : super(db);

  Future<Group> createGroup(GroupEntry groupEntry, {bool recurseProducts = true}) async {
    Group group;
    var products = <Product>[];
    if (recurseProducts) {
      products = await db.productRepository.findAllByGroupId(groupEntry.id, recurseGroup: false);
    }

    var home = await db.homeRepository.findOneById(groupEntry.homeId);

    var modelChanges = await db.modelChangeRepository.findAllByGroupId(groupEntry.id);

    group = Group.fromEntry(groupEntry, home, products: products, modelChanges: modelChanges);

    if (recurseProducts) {
      for (var product in products) {
        product.group = group;
      }
    }

    return group;
  }

  Future<List<Group>> findAllByHomeId(String homeId, {bool recurseProducts = true}) async {
    var entries = await (select(groupTable)..where((c) => c.homeId.equals(homeId))).get();

    var groups = <Group>[];
    for (var entry in entries) {
      groups.add(await createGroup(entry, recurseProducts: recurseProducts));
    }

    return groups;
  }

  Future<List<Group>> findAllByPatternAndHomeId(String pattern, String homeId, {bool recurseProducts = true}) async {
    var entries = await (select(groupTable)..where((c) => (c.name.contains(pattern) | c.pluralName.contains(pattern)) & c.homeId.equals(homeId))).get();

    var groups = <Group>[];
    for (var entry in entries) {
      groups.add(await createGroup(entry, recurseProducts: recurseProducts));
    }

    return groups;
  }

  Future<Group> findOneByGroupId(String groupId, {bool recurseProducts = true}) async {
    if (groupId == null) return null;
    var query = select(groupTable)..where((c) => c.id.equals(groupId));
    var entry = await query.getSingle();
    if (entry == null) return null;

    return createGroup(entry, recurseProducts: recurseProducts);
  }

  Future<Group> save(Group group, User user) async {
    if (group.id == null) {
      group.id = Uuid().v4();
      var change = ModelChange(modificationDate: LocalDate.today(), home: group.home, user: user, modification: ModelChangeType.create, groupId: group.id);
      await db.modelChangeRepository.save(change);
    } else {
      var change = ModelChange(modificationDate: LocalDate.today(), home: group.home, user: user, modification: ModelChangeType.modify, groupId: group.id);
      await db.modelChangeRepository.save(change);

      var oldGroup = await findOneByGroupId(group.id);
      var modifications = oldGroup.getModifications(group);
      for (var modification in modifications) {
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(groupTable).insert(group.toCompanion(), mode: InsertMode.replace);

    return await findOneByGroupId(group.id);
  }

  Future<int> drop(Group group, User user) async {
    assert(group.id != null, "Group is no database object.");

    for (var product in group.products) {
      db.productRepository.drop(product, user);
    }

    var change = ModelChange(user: user, modificationDate: LocalDate.today(), modification: ModelChangeType.delete, home: group.home, groupId: group.id);
    db.modelChangeRepository.save(change);

    return await (delete(groupTable)..where((c) => c.id.equals(group.id))).go();
  }
}
