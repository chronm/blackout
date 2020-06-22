import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/generated/l10n_extension.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_machine/time_machine.dart';

const String DEFAULT_APP_VERSION = "version";

// Home
const String DEFAULT_HOME_NAME = "homeName";
const String DEFAULT_HOME_ID = "homeId";

Home createDefaultHome() => Home(id: DEFAULT_HOME_ID, name: DEFAULT_HOME_NAME);

// User
const String DEFAULT_USER_NAME = "userName";
const String DEFAULT_USER_ID = "userId";

User createDefaultUser() => User(id: DEFAULT_USER_ID, name: DEFAULT_USER_NAME);

// ModelChange
const String DEFAULT_MODEL_CHANGE_ID = "modelChangeId";
LocalDate DEFAULT_MODEL_CHANGE_DATE = LocalDate(2020, 06, 21);
ModelChange createDefaultGroupModelChange() => ModelChange(id: DEFAULT_MODEL_CHANGE_ID, user: createDefaultUser(), modification: ModelChangeType.create, modificationDate: DEFAULT_MODEL_CHANGE_DATE, home: createDefaultHome(), groupId: DEFAULT_GROUP_ID);
ModelChange createDefaultProductModelChange() => ModelChange(id: DEFAULT_MODEL_CHANGE_ID, user: createDefaultUser(), modification: ModelChangeType.create, modificationDate: DEFAULT_MODEL_CHANGE_DATE, home: createDefaultHome(), productId: DEFAULT_PRODUCT_ID);
ModelChange createDefaultChargeModelChange() => ModelChange(id: DEFAULT_MODEL_CHANGE_ID, user: createDefaultUser(), modification: ModelChangeType.create, modificationDate: DEFAULT_MODEL_CHANGE_DATE, home: createDefaultHome(), chargeId: DEFAULT_CHARGE_ID);

// Group
const String DEFAULT_GROUP_ID = "groupId";
const String DEFAULT_GROUP_NAME= "groupName";
const String DEFAULT_GROUP_PLURAL_NAME = "groupPluralName";
Period DEFAULT_GROUP_WARN_INTERVAL = Period(days: 2);
const double DEFAULT_GROUP_REFILL_LIMIT = 2.0;
Group createDefaultGroup() => Group(id:DEFAULT_GROUP_ID, name: DEFAULT_GROUP_NAME, pluralName: DEFAULT_GROUP_PLURAL_NAME, warnInterval: DEFAULT_GROUP_WARN_INTERVAL, refillLimit: DEFAULT_GROUP_REFILL_LIMIT, unit: UnitEnum.unitless, home: createDefaultHome(), modelChanges: [createDefaultGroupModelChange()]);

// Product
const String DEFAULT_PRODUCT_ID = "productId";
const String DEFAULT_PRODUCT_EAN = "productEan";
Period DEFAULT_PRODUCT_WARN_INTERVAL = Period(days: 2);
const double DEFAULT_PRODUCT_REFILL_LIMIT = 2.0;
const String DEFAULT_PRODUCT_DESCRIPTION = "productDescription";
Product createDefaultProduct() => Product(id: DEFAULT_PRODUCT_ID, ean: DEFAULT_PRODUCT_EAN, group: createDefaultGroup(), warnInterval: DEFAULT_PRODUCT_WARN_INTERVAL, refillLimit: DEFAULT_PRODUCT_REFILL_LIMIT, unit: UnitEnum.unitless, home: createDefaultHome(), description: DEFAULT_PRODUCT_DESCRIPTION, modelChanges: [createDefaultProductModelChange()]);

// Charge
const String DEFAULT_CHARGE_ID = "chargeId";
LocalDate DEFAULT_CHARGE_EXPIRATION_DATE = LocalDate(2020, 06, 30);

Charge createDefaultCharge() => Charge(id: DEFAULT_CHANGE_ID, expirationDate: DEFAULT_CHARGE_EXPIRATION_DATE, product: createDefaultProduct(), modelChanges: [createDefaultChargeModelChange()]);

// Change
const String DEFAULT_CHANGE_ID = "changeId";
const double DEFAULT_CHANGE_VALUE = 1.0;
LocalDate DEFAULT_CHANGE_DATE = LocalDate(2020, 06, 21);

Change createDefaultChange() => Change(id: DEFAULT_CHANGE_ID, user: createDefaultUser(), value: DEFAULT_CHANGE_VALUE, changeDate: DEFAULT_CHANGE_DATE, home: createDefaultHome(), charge: createDefaultCharge());

class SharedPreferencesMock extends Mock implements SharedPreferences {}

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
