import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'file:///C:/Users/kevin/Projekte/blackout/lib/features/product_overview/widgets/group_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('Initialize without group', (WidgetTester tester) async {
    await tester.pumpWidget(wrapMaterial(
      widget: GroupSelector(
        initialGroup: null,
        groups: [createDefaultGroup()],
        callback: (c) => group = c,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Group"), findsOneWidget);
    expect(find.text(DEFAULT_CATEGORY_PLURAL_NAME), findsNothing);
  });

  testWidgets('Initialize with initial group and switch group', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    Group group = createDefaultGroup();
    group.products = [product];
    Group group2 = group.clone()..name = "test";
    await tester.pumpWidget(wrapMaterial(
      widget: GroupSelector(
        initialGroup: group,
        groups: [group, group2],
        callback: (c) => group = c,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Group"), findsOneWidget);
    expect(find.text(DEFAULT_CATEGORY_NAME), findsOneWidget);

    await tester.tap(find.text(DEFAULT_CATEGORY_NAME));
    await tester.pumpAndSettle();

    await tester.tap(find.text("test").last);
    await tester.pumpAndSettle();

    expect(group.name, equals("test"));
  });

  testWidgets('Initialize with group and uncheck', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    Group group = createDefaultGroup();
    group.products = [product];

    await tester.pumpWidget(wrapMaterial(
      widget: GroupSelector(
        initialGroup: group,
        groups: [group],
        callback: (c) => group = c,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(group, isNull);
  });
}
