import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/charge.dart';
import '../../models/group.dart';
import '../../models/model_change.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../../util/charge_extension.dart';
import '../database/database.dart';
import '../database/product_table.dart';

part 'product_repository.g.dart';

@UseDao(tables: [ProductTable])
class ProductRepository extends DatabaseAccessor<Database>
    with _$ProductRepositoryMixin {
  ProductRepository(Database db) : super(db);

  Future<Product> createProduct(ProductEntry productEntry,
      {bool recurseGroup = true, bool recurseCharges = true}) async {
    Product product;

    Group group;
    if (recurseGroup) {
      group = await db.groupRepository
          .findOneByGroupId(productEntry.groupId, recurseProducts: false);
    }

    var charges = <Charge>[];
    if (recurseCharges) {
      charges = await db.chargeRepository
          .findAllByProductId(productEntry.id, recurseProduct: false);
      charges = charges.where((c) => c.amount > 0).toList();
    }

    var home = await db.homeRepository.findOneById(productEntry.homeId);

    var modelChanges =
        await db.modelChangeRepository.findAllByProductId(productEntry.id);

    product = Product.fromEntry(productEntry, home,
        group: group, charges: charges, modelChanges: modelChanges);

    if (recurseCharges) {
      for (var charge in product.charges) {
        charge.product = product;
      }
    }

    if (recurseGroup && product.group != null) {
      product.group.products = [product];
    }

    return product;
  }

  Future<List<Product>> findAllByHomeIdAndGroupIsNull(String homeId,
      {bool recurseCharges = true}) async {
    var entries = await (select(productTable)
          ..where((p) => p.homeId.equals(homeId))
          ..where((p) => isNull(p.groupId)))
        .get();

    var products = <Product>[];
    for (var entry in entries) {
      products.add(await createProduct(entry,
          recurseGroup: false, recurseCharges: recurseCharges));
    }

    return products;
  }

  Future<Product> findOneByProductId(String productId,
      {bool recurseGroup = true, bool recurseCharges = true}) async {
    var query = select(productTable)..where((p) => p.id.equals(productId));
    var productEntry = (await query.getSingle());
    if (productEntry == null) return null;

    return await createProduct(productEntry,
        recurseGroup: recurseGroup, recurseCharges: recurseCharges);
  }

  Future<Product> findOneByPatternAndHomeId(String pattern, String homeId,
      {bool recurseGroup = true, bool recurseCharges = true}) async {
    var query = select(productTable)..where((p) => p.ean.equals(pattern));
    var productEntry = (await query.getSingle());
    if (productEntry == null) return null;

    return await createProduct(productEntry,
        recurseGroup: recurseGroup, recurseCharges: recurseCharges);
  }

  Future<List<Product>> findAllByGroupId(String groupId,
      {bool recurseGroup = true}) async {
    var products = <Product>[];

    Group group;
    if (recurseGroup) {
      group = await db.groupRepository
          .findOneByGroupId(groupId, recurseProducts: false);
    }

    var query = select(productTable)..where((p) => p.groupId.equals(groupId));
    var result = await query.get();
    for (var entry in result) {
      var product =
          await createProduct(entry, recurseGroup: false, recurseCharges: true);
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
      var change = ModelChange(
          modificationDate: LocalDate.today(),
          home: product.home,
          user: user,
          modification: ModelChangeType.create,
          productId: product.id);
      await db.modelChangeRepository.save(change);
    } else {
      var change = ModelChange(
          modificationDate: LocalDate.today(),
          home: product.home,
          user: user,
          modification: ModelChangeType.modify,
          productId: product.id);
      await db.modelChangeRepository.save(change);

      var oldProduct = await findOneByProductId(product.id);
      var modifications = oldProduct.getModifications(product);
      for (var modification in modifications) {
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(productTable).insertOnConflictUpdate(product.toCompanion());

    return await findOneByProductId(product.id);
  }

  Future<int> drop(Product product, User user) async {
    assert(product.id != null, "Product is no database object");

    for (var charge in product.charges) {
      db.chargeRepository.drop(charge, user);
    }

    var change = ModelChange(
        user: user,
        modificationDate: LocalDate.today(),
        modification: ModelChangeType.delete,
        home: product.home,
        productId: product.id);
    db.modelChangeRepository.save(change);

    return await (delete(productTable)..where((p) => p.id.equals(product.id)))
        .go();
  }
}
