import 'package:Blackout/data/database/category_table.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:optional/optional.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'category_repository.g.dart';

@UseDao(tables: [CategoryTable])
class CategoryRepository extends DatabaseAccessor<Database> with _$CategoryRepositoryMixin {
  CategoryRepository(Database db) : super(db);

  Future<Category> createCategory(CategoryEntry categoryEntry, {bool recurseProducts = true}) async {
    Category category;
    List<Product> products = [];
    if (recurseProducts) {
      products = await db.productRepository.getAllByCategoryIdAndHomeId(categoryEntry.id, categoryEntry.homeId, recurseCategory: false);
    }

    Home home = await db.homeRepository.getHomeById(categoryEntry.homeId);
    category = Category.fromEntry(categoryEntry, home, products: products);

    if (recurseProducts) {
      products.forEach((p) => p.category = category);
    }

    return category;
  }

  Future<List<Category>> findAllByHomeId(String homeId, {bool recurseProducts = true}) async {
    List<CategoryEntry> entries = await (select(categoryTable)..where((c) => c.homeId.equals(homeId))).get();

    List<Category> categories = [];
    for (CategoryEntry entry in entries) {
      categories.add(await createCategory(entry, recurseProducts: recurseProducts));
    }

    return categories;
  }

  Future<Optional<Category>> findOneByCategoryIdAndHomeId(String categoryId, String homeId, {bool recurseProducts = true}) async {
    return Optional.ofNullable(await getOneByCategoryIdAndHomeId(categoryId, homeId, recurseProducts: recurseProducts));
  }

  Future<Category> getOneByCategoryIdAndHomeId(String categoryId, String homeId, {bool recurseProducts = true}) async {
    if (categoryId == null) return null;
    var query = select(categoryTable)..where((c) => c.id.equals(categoryId))..where((c) => c.homeId.equals(homeId));
    CategoryEntry entry = await query.getSingle();
    if (entry == null) return null;

    return createCategory(entry, recurseProducts: recurseProducts);
  }

  Future<Category> save(Category category, User user) async {
    if (category.id == null) {
      category.id = Uuid().v4();
      ModelChange change = ModelChange(modificationDate: LocalDateTime.now(), home: category.home, user: user, modification: ModelChangeType.create, categoryId: category.id);
      await db.modelChangeRepository.save(change);
    } else {
      ModelChange change = ModelChange(modificationDate: LocalDateTime.now(), home: category.home, user: user, modification: ModelChangeType.modify, categoryId: category.id);
      await db.modelChangeRepository.save(change);

      Category oldCategory = await getOneByCategoryIdAndHomeId(category.id, category.home.id);
      List<Modification> modifications = oldCategory.getModifications(category);
      for (Modification modification in modifications) {
        modification.home = category.home;
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(categoryTable).insertOnConflictUpdate(category.toCompanion());

    return await getOneByCategoryIdAndHomeId(category.id, category.home.id);
  }

  Future<int> drop(Category category) async {
    assert(category.id != null, "Category is no database object.");

    category.products.forEach((p) => db.productRepository.drop(p));

    return await (delete(categoryTable)..where((c) => c.id.equals(category.id))).go();
  }
}
