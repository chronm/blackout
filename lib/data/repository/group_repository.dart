import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/group_table.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'group_repository.g.dart';

@UseDao(tables: [GroupTable])
class GroupRepository extends DatabaseAccessor<Database> with _$GroupRepositoryMixin {
  GroupRepository(Database db) : super(db);

  Future<Group> createGroup(GroupEntry groupEntry, {bool recurseProducts = true}) async {
    Group group;
    List<Product> products = [];
    if (recurseProducts) {
      products = await db.productRepository.findAllByGroupId(groupEntry.id, recurseGroup: false);
    }

    Home home = await db.homeRepository.findOneById(groupEntry.homeId);

    List<ModelChange> modelChanges = await db.modelChangeRepository.findAllByGroupId(groupEntry.id);

    group = Group.fromEntry(groupEntry, home, products: products, modelChanges: modelChanges);

    if (recurseProducts) {
      products.forEach((p) => p.group = group);
    }

    return group;
  }

  Future<List<Group>> findAllByHomeId(String homeId, {bool recurseProducts = true}) async {
    List<GroupEntry> entries = await (select(groupTable)..where((c) => c.homeId.equals(homeId))).get();

    List<Group> groups = [];
    for (GroupEntry entry in entries) {
      groups.add(await createGroup(entry, recurseProducts: recurseProducts));
    }

    return groups;
  }

  Future<List<Group>> findAllByPatternAndHomeId(String pattern, String homeId, {bool recurseProducts = true}) async {
    List<GroupEntry> entries = await (select(groupTable)..where((c) => (c.name.contains(pattern) | c.pluralName.contains(pattern)) & c.homeId.equals(homeId))).get();

    List<Group> groups = [];
    for (GroupEntry entry in entries) {
      groups.add(await createGroup(entry, recurseProducts: recurseProducts));
    }

    return groups;
  }

  Future<Group> findOneByGroupId(String groupId, {bool recurseProducts = true}) async {
    if (groupId == null) return null;
    var query = select(groupTable)..where((c) => c.id.equals(groupId));
    GroupEntry entry = await query.getSingle();
    if (entry == null) return null;

    return createGroup(entry, recurseProducts: recurseProducts);
  }

  Future<Group> save(Group group, User user) async {
    if (group.id == null) {
      group.id = Uuid().v4();
      ModelChange change = ModelChange(modificationDate: LocalDate.today(), home: group.home, user: user, modification: ModelChangeType.create, groupId: group.id);
      await db.modelChangeRepository.save(change);
    } else {
      ModelChange change = ModelChange(modificationDate: LocalDate.today(), home: group.home, user: user, modification: ModelChangeType.modify, groupId: group.id);
      await db.modelChangeRepository.save(change);

      Group oldGroup = await findOneByGroupId(group.id);
      List<Modification> modifications = oldGroup.getModifications(group);
      for (Modification modification in modifications) {
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(groupTable).insertOnConflictUpdate(group.toCompanion());

    return await findOneByGroupId(group.id);
  }

  Future<int> drop(Group group, User user) async {
    assert(group.id != null, "Group is no database object.");

    group.products.forEach((p) => db.productRepository.drop(p, user));

    ModelChange change = ModelChange(user: user, modificationDate: LocalDate.today(), modification: ModelChangeType.delete, home: group.home, groupId: group.id);
    db.modelChangeRepository.save(change);

    return await (delete(groupTable)..where((c) => c.id.equals(group.id))).go();
  }
}
