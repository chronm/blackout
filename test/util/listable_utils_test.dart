import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/listable_utils.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

import '../blackout_test_base.dart';

void main() {
  testWidgets('(BuildListableListItem)', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];

    await tester.pumpWidget(
      wrapMaterial(builder: (context) => buildProductListItem(context, product, () {})),
    );
    await tester.pumpAndSettle();

    expect(find.text(DEFAULT_PRODUCT_DESCRIPTION), findsOneWidget);
    expect(find.text("Available: 1"), findsOneWidget);
  });

  testWidgets('(BuildListableListItem) show expiration and refill', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.notificationDate = LocalDateTime.now();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    product.refillLimit = 2;

    await tester.pumpWidget(
      wrapMaterial(builder: (context) => buildProductListItem(context, product, () {})),
    );
    await tester.pumpAndSettle();

    expect(find.text(DEFAULT_PRODUCT_DESCRIPTION), findsOneWidget);
    expect(find.text("Available: 1"), findsOneWidget);
    expect(find.byIcon(Icons.event), findsOneWidget);
    expect(find.byIcon(Icons.trending_down), findsOneWidget);
  });

  testWidgets('(BuildItemListItem) expirationDate before now', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.expirationDate = LocalDateTime.now().subtractYears(1);
    item.changes = [change];
    ModelChange modelChange = createDefaultModelChange(ModelChangeType.create, item: item..id = DEFAULT_ITEM_ID);
    BuildContext context;

    await tester.pumpWidget(
      wrapMaterial(
        builder: (context) => buildItemListItem(context, item, [modelChange], () {}),
        contextCallback: (c) => context = c,
      ),
    );
    await tester.pumpAndSettle();

    String test = "${NOW.prettyPrintShortDifference(context).capitalize()} created - Expired ${item.expirationDate.prettyPrintShortDifference(context)}";

    expect(find.text('Available: 1'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data == test;
      }
      return false;
    }), findsOneWidget);
    expect(find.text(test), findsOneWidget);
  });

  testWidgets('(BuildItemListItem) expirationDate after now', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    ModelChange modelChange = createDefaultModelChange(ModelChangeType.create, item: item..id = DEFAULT_ITEM_ID);
    BuildContext context;

    await tester.pumpWidget(
      wrapMaterial(
        builder: (context) => buildItemListItem(context, item, [modelChange], () {}),
        contextCallback: (c) => context = c,
      ),
    );
    await tester.pumpAndSettle();

    String test = "${NOW.prettyPrintShortDifference(context).capitalize()} created - Expires ${item.expirationDate.prettyPrintShortDifference(context)}";

    expect(find.text('Available: 1'), findsOneWidget);
    expect(find.text(test), findsOneWidget);
  });

  testWidgets('(BuildItemListItem) with notificationDate', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.expirationDate = null;
    item.changes = [change];
    ModelChange modelChange = createDefaultModelChange(ModelChangeType.create, item: item..id = DEFAULT_ITEM_ID);
    BuildContext context;

    await tester.pumpWidget(
      wrapMaterial(
        builder: (context) => buildItemListItem(context, item, [modelChange], () {}),
        contextCallback: (c) => context = c,
      ),
    );
    await tester.pumpAndSettle();

    String test = "${NOW.prettyPrintShortDifference(context).capitalize()} created - Notify ${DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(item.notificationDate.toDateTimeLocal())}";

    expect(find.text('Available: 1'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data == test;
      }
      return false;
    }), findsOneWidget);
  });

  testWidgets('(BuildItemListItem) without expirationDate and notificationDate)', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.expirationDate = null;
    item.notificationDate = null;
    item.changes = [change];
    ModelChange modelChange = createDefaultModelChange(ModelChangeType.create, item: item..id = DEFAULT_ITEM_ID);
    BuildContext context;

    await tester.pumpWidget(
      wrapMaterial(
        builder: (context) => buildItemListItem(context, item, [modelChange], () {}),
        contextCallback: (c) => context = c,
      ),
    );
    await tester.pumpAndSettle();

    String test = "${NOW.prettyPrintShortDifference(context).capitalize()} created";

    expect(find.text('Available: 1'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data == test;
      }
      return false;
    }), findsOneWidget);
  });
}
