import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/data/database/product_table.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
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

  Future<Product> createProduct(ProductEntry productEntry, {bool recurseCategory = true, bool recurseItems = true}) async {
    Product product;

    Category category;
    if (recurseCategory) {
      category = await db.categoryRepository.getOneByCategoryIdAndHomeId(productEntry.categoryId, productEntry.homeId, recurseProducts: false);
    }

    List<Item> items = [];
    if (recurseItems) {
      items = await db.itemRepository.getAllByProductIdAndHomeId(productEntry.id, productEntry.homeId, recurseProduct: false);
    }

    Home home = await db.homeRepository.getHomeById(productEntry.homeId);

    product = Product.fromEntry(productEntry, home, category: category, items: items);

    if (recurseItems) {
      product.items.forEach((i) => i.product = product);
    }

    if (recurseCategory && product.category != null) {
      product.category.products = [product];
    }

    return product;
  }

  Future<List<Product>> findAllByHomeIdAndCategoryIsNull(String homeId, {bool recurseItems = true}) async {
    List<ProductEntry> entries = await (select(productTable)..where((p) => p.homeId.equals(homeId))..where((p) => isNull(p.categoryId))).get();

    List<Product> products = [];
    for (ProductEntry entry in entries) {
      products.add(await createProduct(entry, recurseCategory: false, recurseItems: recurseItems));
    }

    return products;
  }

  Future<List<Product>> findAllByHomeId(String homeId, {bool recurseItems = true}) async {
    List<ProductEntry> entries = await (select(productTable)..where((p) => p.homeId.equals(homeId))).get();

    List<Product> products = [];
    for (ProductEntry entry in entries) {
      products.add(await createProduct(entry, recurseItems: recurseItems));
    }

    return products;
  }

  Future<Optional<Product>> findOneByProductIdAndHomeId(String productId, String homeId, {bool recurseCategory = true, bool recurseItem = true}) async {
    return Optional.ofNullable(await getOneByProductIdAndHomeId(productId, homeId, recurseCategory: recurseItem, recurseItems: recurseItem));
  }

  Future<Product> getOneByProductIdAndHomeId(String productId, String homeId, {bool recurseCategory = true, bool recurseItems = true}) async {
    var query = select(productTable)..where((p) => p.id.equals(productId));
    ProductEntry productEntry = (await query.getSingle());
    if (productEntry == null) return null;

    return await createProduct(productEntry, recurseCategory: recurseCategory, recurseItems: recurseItems);
  }

  Future<List<Product>> getAllByCategoryIdAndHomeId(String categoryId, String homeId, {bool recurseCategory = true}) async {
    List<Product> products = [];

    Category category;
    if (recurseCategory) {
      category = await db.categoryRepository.getOneByCategoryIdAndHomeId(categoryId, homeId, recurseProducts: false);
    }

    var query = select(productTable)..where((p) => p.categoryId.equals(categoryId));
    var result = await query.get();
    for (ProductEntry entry in result) {
      Product product = await createProduct(entry, recurseCategory: false, recurseItems: true);
      product.category = category;
      products.add(product);
    }

    if (recurseCategory) {
      category.products = products;
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

    await into(productTable).insert(product.toCompanion(), mode: InsertMode.insertOrReplace);

    return await getOneByProductIdAndHomeId(product.id, product.home.id);
  }

  Future<int> drop(Product product) async {
    assert(product.id != null, "Product is no database object");

    product.items.forEach((i) => db.itemRepository.drop(i));

    return await (delete(productTable)..where((p) => p.id.equals(product.id))).go();
  }
}
