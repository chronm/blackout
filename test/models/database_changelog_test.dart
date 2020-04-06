import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {

  Category category = createDefaultCategory()..id = DEFAULT_CATEGORY_ID;
  Product product = createDefaultProduct()..id = DEFAULT_PRODUCT_ID;
  Item item = createDefaultItem()..id = DEFAULT_ITEM_ID;

  test('(DatabaseChangelog) new DatabsaeChangelog for a category and product fails', () {
    expect(() => createDefaultDatabaseChangelog(ChangelogModification.create, category: category, product: product), throwsAssertionError);
  });

  test('(DatabaseChangelog) new DatabsaeChangelog for a category and item fails', () {
    expect(() => createDefaultDatabaseChangelog(ChangelogModification.create, category: category, item: item), throwsAssertionError);
  });

  test('(DatabaseChangelog) new DatabsaeChangelog for a product and item fails', () {
    expect(() => createDefaultDatabaseChangelog(ChangelogModification.create, product: product, item: item), throwsAssertionError);
  });

  test('(DatabaseChangelog) new DatabsaeChangelog for a category, product and item fails', () {
    expect(() => createDefaultDatabaseChangelog(ChangelogModification.create, category: category, product: product, item: item), throwsAssertionError);
  });

  test('(DatabaseChangelog) new DataaseChangelog for category succeedes', () {
    DatabaseChangelog changelog = createDefaultDatabaseChangelog(ChangelogModification.create, category: category);

    expect(changelog.categoryId, equals(category.id));
  });

  test('(DatabaseChangelog) new DataaseChangelog for product succeedes', () {
    DatabaseChangelog changelog = createDefaultDatabaseChangelog(ChangelogModification.create, product: product);

    expect(changelog.productId, equals(product.id));
  });

  test('(DatabaseChangelog) new DataaseChangelog for item succeedes', () {
    DatabaseChangelog changelog = createDefaultDatabaseChangelog(ChangelogModification.create, item: item);

    expect(changelog.itemId, equals(item.id));
  });
}