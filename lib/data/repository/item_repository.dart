import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/item_table.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional.dart';
import 'package:uuid/uuid.dart';

part 'item_repository.g.dart';

@UseDao(tables: [ItemTable])
class ItemRepository extends DatabaseAccessor<Database> with _$ItemRepositoryMixin {
  ItemRepository(Database db) : super(db);

  Future<Item> createItem(ItemEntry itemEntry, {bool recurseProduct = true, bool recurseChanges = true}) async {
    Item item;

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.getOneByProductIdAndHomeId(itemEntry.productId, itemEntry.homeId, recurseItems: false);
    }

    List<Change> changes = [];
    if (recurseChanges) {
      changes = await db.changeRepository.getAllByItemIdAndHomeId(itemEntry.id, itemEntry.homeId, recurseItem: false);
    }

    Home home = await db.homeRepository.getHomeById(itemEntry.homeId);

    item = Item.fromEntry(itemEntry, home, product: product, changes: changes);

    if (recurseChanges) {
      item.changes.forEach((c) => c.item = item);
    }

    if (recurseProduct && item.product != null) {
      item.product.items = [item];
    }

    return item;
  }

  Future<List<Item>> findAllByHomeId(String homeId, {bool recurseChanges = true}) async {
    List<ItemEntry> entries = await (select(itemTable)..where((i) => i.homeId.equals(homeId))).get();

    List<Item> items = [];
    for (ItemEntry entry in entries) {
      items.add(await createItem(entry, recurseChanges: recurseChanges));
    }

    return items;
  }

  Future<Optional<Item>> findOneByItemIdAndHomeId(String itemId, String homeId, {bool recurseProduct = true, bool recurseChanges = true}) async {
    return Optional.ofNullable(await getOneByItemIdAndHomeId(itemId, homeId, recurseProduct: recurseProduct, recurseChanges: recurseChanges));
  }

  Future<Item> getOneByItemIdAndHomeId(String itemId, String homeId, {bool recurseProduct = true, bool recurseChanges = true}) async {
    var query = select(itemTable)..where((i) => i.id.equals(itemId))..where((i) => i.homeId.equals(homeId));
    ItemEntry itemEntry = (await query.getSingle());
    if (itemEntry == null) return null;

    return await createItem(itemEntry, recurseProduct: recurseProduct, recurseChanges: recurseChanges);
  }

  Future<List<Item>> getAllByProductIdAndHomeId(String productId, String homeId, {bool recurseProduct = true}) async {
    List<Item> items = [];

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.getOneByProductIdAndHomeId(productId, homeId, recurseCategory: false, recurseItems: false);
    }

    var query = select(itemTable)..where((p) => p.productId.equals(productId));
    var result = await query.get();
    for (ItemEntry itemEntry in result) {
      Item item = await createItem(itemEntry, recurseProduct: false, recurseChanges: true);
      item.product = product;
      items.add(item);
    }

    if (recurseProduct) {
      product.items = items;
    }

    return items;
  }

  Future<Item> save(Item item) async {
    item.id ??= Uuid().v4();

    await into(itemTable).insertOnConflictUpdate(item.toCompanion());

    return await getOneByItemIdAndHomeId(item.id, item.home.id);
  }

  Future<int> drop(Item item) async {
    assert(item.id != null, "Item is no database object");

    item.changes.forEach((c) => db.changeRepository.drop(c));

    return await (delete(itemTable)..where((i) => i.id.equals(item.id))).go();
  }
}
