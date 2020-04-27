import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/modification_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/generated/l10n_extension.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/sync.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_machine/time_machine.dart';

final Period DEFAULT_PERIOD_UNTIL_EXPIRATION = Period(weeks: 1);

final Period DEFAULT_PERIOD_UNTIL_NOTIFICATION = Period(days: 6);

final LocalDateTime NOW = LocalDateTime.now();

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
final Period DEFAULT_CATEGORY_WARN_INTERVAL = periodFromISO8601String("P8D");

Category createDefaultCategory() {
  return Category(
    name: DEFAULT_CATEGORY_NAME,
    pluralName: DEFAULT_CATEGORY_PLURAL_NAME,
    warnInterval: DEFAULT_CATEGORY_WARN_INTERVAL,
    home: createDefaultHome(),
    unit: UnitEnum.unitless,
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
final LocalDateTime DEFAULT_ITEM_EXPIRATION_DATE = NOW.add(DEFAULT_PERIOD_UNTIL_EXPIRATION);
final LocalDateTime DEFAULT_ITEM_NOTIFICATION_DATE = NOW.add(DEFAULT_PERIOD_UNTIL_NOTIFICATION);

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
final LocalDateTime DEFAULT_CHANGE_CHANGE_DATE = NOW;

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
final String DEFAULT_MODEL_CHANGE_ID = "databaseChangelogId";
final LocalDateTime DEFAULT_MODEL_CHANGE_MODIFICATION_DATE = DEFAULT_CHANGE_CHANGE_DATE;

ModelChange createDefaultModelChange(ModelChangeType modification, {Category category, Product product, Item item}) {
  return ModelChange(
    id: DEFAULT_MODEL_CHANGE_ID,
    user: createDefaultUser(),
    modificationDate: DEFAULT_MODEL_CHANGE_MODIFICATION_DATE,
    modification: modification,
    home: createDefaultHome(),
    categoryId: category != null ? category.id : null,
    productId: product != null ? product.id : null,
    itemId: item != null ? item.id : null,
  );
}

// Sync
final LocalDateTime SYNC_SYNCHRONIZATION_DATE = NOW;

Sync createDefaultSync() {
  return Sync(
    synchronizationDate: SYNC_SYNCHRONIZATION_DATE,
    user: createDefaultUser(),
    home: createDefaultHome(),
  );
}

// Modification
final String DEFAULT_MODIFICATION_ID = "modificationId";
final String DEFAULT_MODIFICATION_FIELD_NAME = "fieldName";
final String DEFAULT_MODIFICATION_FROM = "from";
final String DEFAULT_MODIFICATION_TO = "to";

Modification createDefaultModification() {
  return Modification(
    id: DEFAULT_MODIFICATION_ID,
    fieldName: DEFAULT_MODIFICATION_FIELD_NAME,
    from: DEFAULT_MODIFICATION_FROM,
    to: DEFAULT_MODIFICATION_TO,
    home: createDefaultHome(),
    modelChange: createDefaultModelChange(ModelChangeType.create, category: createDefaultCategory()..id = DEFAULT_CATEGORY_ID),
  );
}

MaterialApp wrapMaterial(Widget widget) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blackout",
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: S.delegate.resolution(fallback: Locale("en", "")),
      home: Scaffold(
        body: widget,
      ),
    );

typedef void ContextFactory(BuildContext buildContext);

Future<BuildContext> DEFAULT_BUILD_CONTEXT(WidgetTester tester) async {
  BuildContext context;
  await tester.pumpWidget(
    _TestApp(
      factory: (_context) {
        context = _context;
      },
    ),
  );
  await tester.pumpAndSettle();

  return context;
}

class _TestApp extends StatelessWidget {
  final ContextFactory factory;

  _TestApp({Key key, this.factory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Blackout",
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: S.delegate.resolution(fallback: Locale("en", "")),
      home: _Home(
        factory: factory,
      ),
    );
  }
}

class _Home extends StatefulWidget {
  final ContextFactory factory;

  _Home({Key key, this.factory}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    widget.factory(context);
    return Container();
  }
}

class BlackoutPreferencesMock extends Mock implements BlackoutPreferences {}

class CategoryBlocMock extends MockBloc<CategoryEvent, CategoryState> implements CategoryBloc {}

class CategoryRepositoryMock extends Mock implements CategoryRepository {}

class ChangeRepositoryMock extends Mock implements ChangeRepository {}

class HomeBlocMock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class HomeRepositoryMock extends Mock implements HomeRepository {}

class ItemRepositoryMock extends Mock implements ItemRepository {}

class ModelChangeRepositoryMock extends Mock implements ModelChangeRepository {}

class ModificationRepositoryMock extends Mock implements ModificationRepository {}

class ProductRepositoryMock extends Mock implements ProductRepository {}

class UserRepositoryMock extends Mock implements UserRepository {}
