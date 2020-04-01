import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/sync.dart';
import 'package:Blackout/models/user.dart';
import 'package:time_machine/time_machine.dart';

final Period DEFAULT_PERIOD_UNTIL_EXPIRATION = Period(weeks: 1);

final Period DEFAULT_PERIOD_UNTIL_NOTIFICATION = Period(days: 6);

// Home
final String DEFAULT_HOME_ID = "defaultHomeId";
final String DEFAULT_HOME_NAME = "homeName";

Home createDefaultHome() {
  return Home(
    id: DEFAULT_HOME_ID,
    name: DEFAULT_HOME_NAME,
  );
}

// Category
final String DEFAULT_CATEGORY_ID = "categoryId";
final String DEFAULT_CATEGORY_NAME = "categoryName";
final String DEFAULT_CATEGORY_PLURAL_NAME = "categoryPluralName";
final Period DEFAULT_CATEGORY_WARN_INTERVAL = Period.zero;

Category createDefaultCategory() {
  return Category(
    name: DEFAULT_CATEGORY_NAME,
    pluralName: DEFAULT_CATEGORY_PLURAL_NAME,
    warnInterval: DEFAULT_CATEGORY_WARN_INTERVAL,
    home: createDefaultHome(),
  );
}

// Product
final String DEFAULT_PRODUCT_ID = "productId";
final String DEFAULT_PRODUCT_EAN = "productEan";
final String DEFAULT_PRODUCT_DESCRIPTION = "productCategory";

Product createDefaultProduct() {
  return Product(
    ean: DEFAULT_PRODUCT_EAN,
    description: DEFAULT_PRODUCT_DESCRIPTION,
    home: createDefaultHome(),
  );
}

// Item
final String DEFAULT_ITEM_ID = "itemid";
final LocalDateTime DEFAULT_ITEM_EXPIRATION_DATE = LocalDateTime(2020, 3, 25, 12, 49, 00).add(DEFAULT_PERIOD_UNTIL_EXPIRATION);
final LocalDateTime DEFAULT_ITEM_NOTIFICATION_DATE = LocalDateTime(2020, 3, 25, 12, 49, 00).add(DEFAULT_PERIOD_UNTIL_NOTIFICATION);

Item createDefaultItem() {
  return Item(
    expirationDate: DEFAULT_ITEM_EXPIRATION_DATE,
    notificationDate: DEFAULT_ITEM_NOTIFICATION_DATE,
    product: createDefaultProduct(),
    home: createDefaultHome(),
  );
}

// Change
final String DEFAULT_CHANGE_ID = "changeId";
final String DEFAULT_CHANGE_OWNER = "changeOwner";
final double DEFAULT_CHANGE_VALUE = 1.0;
final LocalDateTime DEFAULT_CHANGE_CHANGE_DATE = LocalDateTime(2020, 3, 25, 12, 49, 00);

Change createDefaultChange() {
  return Change(
    user: createDefaultUser(),
    value: DEFAULT_CHANGE_VALUE,
    changeDate: DEFAULT_CHANGE_CHANGE_DATE,
    item: createDefaultItem(),
    home: createDefaultHome(),
  );
}

// User
final String DEFAULT_USER_ID = "userId";
final String DEFAULT_USER_NAME = "userName";

User createDefaultUser() {
  return User(
    id: DEFAULT_USER_ID,
    name: DEFAULT_USER_NAME,
  );
}

// DatabaseChangelog
final String DEFAULT_DATABASE_CHANGE_LOG_ID = "databaseChangelogId";
final LocalDateTime DEFAULT_DATABASE_CHANGELOG_MODIFICATION_DATE = LocalDateTime(2020, 3, 25, 12, 49, 00);

DatabaseChangelog createDefaultDatabaseChangelog(ChangelogModification modification, {Category category, Product product, Item item}) {
  return DatabaseChangelog(
    id: DEFAULT_DATABASE_CHANGE_LOG_ID,
    user: createDefaultUser(),
    modificationDate: DEFAULT_DATABASE_CHANGELOG_MODIFICATION_DATE,
    modification: modification,
    home: createDefaultHome(),
    categoryId: category != null ? category.id : null,
    productId: product != null ? product.id : null,
    itemId: item != null ? item.id : null,
  );
}

// Sync
final LocalDateTime SYNC_SYNCHRONIZATION_DATE = LocalDateTime(2020, 3, 25, 12, 49, 00);

Sync createDefaultSync() {
  return Sync(
    synchronizationDate: SYNC_SYNCHRONIZATION_DATE,
    user: createDefaultUser(),
    home: createDefaultHome(),
  );
}
