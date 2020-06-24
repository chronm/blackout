import 'package:Blackout/data/preferences/blackout_preferences.dart';
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

const String defaultAppVersion = "version";

// Home
const String defaultHomeName = "homeName";
const String defaultHomeId = "homeId";

Home createDefaultHome() => Home(id: defaultHomeId, name: defaultHomeName);

// User
const String defaultUserName = "userName";
const String defaultUserId = "userId";

User createDefaultUser() => User(id: defaultUserId, name: defaultUserName);

// ModelChange
const String defaultModelChangeId = "modelChangeId";
LocalDate defaultModelChangeDate = LocalDate(2020, 06, 21);

ModelChange createDefaultGroupModelChange() => ModelChange(
    id: defaultModelChangeId,
    user: createDefaultUser(),
    modification: ModelChangeType.create,
    modificationDate: defaultModelChangeDate,
    home: createDefaultHome(),
    groupId: defaultGroupId);

ModelChange createDefaultProductModelChange() => ModelChange(
      id: defaultModelChangeId,
      user: createDefaultUser(),
      modification: ModelChangeType.create,
      modificationDate: defaultModelChangeDate,
      home: createDefaultHome(),
      productId: defaultProductId,
    );

ModelChange createDefaultChargeModelChange() => ModelChange(
      id: defaultModelChangeId,
      user: createDefaultUser(),
      modification: ModelChangeType.create,
      modificationDate: defaultModelChangeDate,
      home: createDefaultHome(),
      chargeId: defaultChargeId,
    );

// Group
const String defaultGroupId = "groupId";
const String defaultGroupName = "groupName";
const String defaultGroupPluralName = "groupPluralName";
Period defaultGroupWarnInterval = Period(days: 2);
const double defaultGroupRefillLimit = 2.0;

Group createDefaultGroup() => Group(
      id: defaultGroupId,
      name: defaultGroupName,
      pluralName: defaultGroupPluralName,
      warnInterval: defaultGroupWarnInterval,
      refillLimit: defaultGroupRefillLimit,
      unit: UnitEnum.unitless,
      home: createDefaultHome(),
      modelChanges: [createDefaultGroupModelChange()],
    );

// Product
const String defaultProductId = "productId";
const String defaultProductEan = "productEan";
Period defaultProductWarnInterval = Period(days: 2);
const double defaultProductRefillLimit = 2.0;
const String defaultProductDescription = "productDescription";

Product createDefaultProduct() => Product(
    id: defaultProductId,
    ean: defaultProductEan,
    group: createDefaultGroup(),
    warnInterval: defaultProductWarnInterval,
    refillLimit: defaultProductRefillLimit,
    unit: UnitEnum.unitless,
    home: createDefaultHome(),
    description: defaultProductDescription,
    modelChanges: [createDefaultProductModelChange()]);

// Charge
const String defaultChargeId = "chargeId";
LocalDate defaultChargeExpirationDate = LocalDate(2020, 06, 30);

Charge createDefaultCharge() => Charge(
      id: defaultChangeId,
      expirationDate: defaultChargeExpirationDate,
      product: createDefaultProduct(),
      modelChanges: [createDefaultChargeModelChange()],
    );

// Change
const String defaultChangeId = "changeId";
const double defaultChangeValue = 1.0;
LocalDate defaultChangeDate = LocalDate(2020, 06, 21);

Change createDefaultChange() => Change(
      id: defaultChangeId,
      user: createDefaultUser(),
      value: defaultChangeValue,
      changeDate: defaultChangeDate,
      home: createDefaultHome(),
      charge: createDefaultCharge(),
    );

typedef ContextFactory = void Function(BuildContext buildContext);

Future<BuildContext> defaultBuildContext(WidgetTester tester) async {
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
      localeResolutionCallback:
          S.delegate.resolution(fallback: Locale("en", "")),
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

class SharedPreferencesMock extends Mock implements SharedPreferences {}

class BlackoutPreferencesMock extends Mock implements BlackoutPreferences {}
