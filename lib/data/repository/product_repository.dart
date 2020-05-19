import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/product_table.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'product_repository.g.dart';

@UseDao(tables: [ProductTable])
class ProductRepository extends DatabaseAccessor<Database> with _$ProductRepositoryMixin {
  ProductRepository(Database db) : super(db);

  Future<Product> createProduct(ProductEntry productEntry, {bool recurseGroup = true, bool recurseCharges = true}) async {
    Product product;

    Group group;
    if (recurseGroup) {
      group = await db.groupRepository.getOneByGroupIdAndHomeId(productEntry.groupId, productEntry.homeId, recurseProducts: false);
    }

    List<Charge> charges = [];
    if (recurseCharges) {
      charges = await db.chargeRepository.getAllByProductIdAndHomeId(productEntry.id, productEntry.homeId, recurseProduct: false);
    }

    Home home = await db.homeRepository.getHomeById(productEntry.homeId);

    List<ModelChange> modelChanges = await db.modelChangeRepository.findAllByProductIdAndHomeId(productEntry.id, home.id);

    product = Product.fromEntry(productEntry, home, group: group, charges: charges, modelChanges: modelChanges);

    if (recurseCharges) {
      product.charges.forEach((i) => i.product = product);
    }

    if (recurseGroup && product.group != null) {
      product.group.products = [product];
    }

    return product;
  }

  Future<List<Product>> findAllByHomeIdAndGroupIsNull(String homeId, {bool recurseCharges = true}) async {
    List<ProductEntry> entries = await (select(productTable)..where((p) => p.homeId.equals(homeId))..where((p) => isNull(p.groupId))).get();

    List<Product> products = [];
    for (ProductEntry entry in entries) {
      products.add(await createProduct(entry, recurseGroup: false, recurseCharges: recurseCharges));
    }

    return products;
  }

  Future<List<Product>> findAllByHomeId(String homeId, {bool recurseCharges = true}) async {
    List<ProductEntry> entries = await (select(productTable)..where((p) => p.homeId.equals(homeId))).get();

    List<Product> products = [];
    for (ProductEntry entry in entries) {
      products.add(await createProduct(entry, recurseCharges: recurseCharges));
    }

    return products;
  }

  Future<Optional<Product>> findOneByProductIdAndHomeId(String productId, String homeId, {bool recurseGroup = true, bool recurseCharge = true}) async {
    return Optional.ofNullable(await getOneByProductIdAndHomeId(productId, homeId, recurseGroup: recurseCharge, recurseCharges: recurseCharge));
  }

  Future<Product> getOneByProductIdAndHomeId(String productId, String homeId, {bool recurseGroup = true, bool recurseCharges = true}) async {
    var query = select(productTable)..where((p) => p.id.equals(productId));
    ProductEntry productEntry = (await query.getSingle());
    if (productEntry == null) return null;

    return await createProduct(productEntry, recurseGroup: recurseGroup, recurseCharges: recurseCharges);
  }

  Future<List<Product>> getAllByGroupIdAndHomeId(String groupId, String homeId, {bool recurseGroup = true}) async {
    List<Product> products = [];

    Group group;
    if (recurseGroup) {
      group = await db.groupRepository.getOneByGroupIdAndHomeId(groupId, homeId, recurseProducts: false);
    }

    var query = select(productTable)..where((p) => p.groupId.equals(groupId));
    var result = await query.get();
    for (ProductEntry entry in result) {
      Product product = await createProduct(entry, recurseGroup: false, recurseCharges: true);
      product.group = group;
      products.add(product);
    }

    if (recurseGroup) {
      group.products = products;
    }

    return products;
  }

  Future<Product> save(Product product, User user) async {
    if (product.id == null) {
      product.id ??= Uuid().v4();
      ModelChange change = ModelChange(modificationDate: LocalDateTime.now(), home: product.home, user: user, modification: ModelChangeType.create, productId: product.id);
      await db.modelChangeRepository.save(change);
    } else {
      ModelChange change = ModelChange(modificationDate: LocalDateTime.now(), home: product.home, user: user, modification: ModelChangeType.modify, productId: product.id);
      await db.modelChangeRepository.save(change);

      Product oldProduct = await getOneByProductIdAndHomeId(product.id, product.home.id);
      List<Modification> modifications = oldProduct.getModifications(product);
      for (Modification modification in modifications) {
        modification.home = product.home;
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(productTable).insertOnConflictUpdate(product.toCompanion());

    return await getOneByProductIdAndHomeId(product.id, product.home.id);
  }

  Future<int> drop(Product product) async {
    assert(product.id != null, "Product is no database object");

    product.charges.forEach((i) => db.chargeRepository.drop(i));

    return await (delete(productTable)..where((p) => p.id.equals(product.id))).go();
  }
}
