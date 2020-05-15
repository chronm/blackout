import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/widget/category_selector/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('Initialize without category', (WidgetTester tester) async {
    Category category;
    await tester.pumpWidget(wrapMaterial(
      widget: CategorySelector(
        initialCategory: null,
        categories: [createDefaultCategory()],
        callback: (c) => category = c,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Category"), findsOneWidget);
    expect(find.text(DEFAULT_CATEGORY_PLURAL_NAME), findsNothing);
  });

  testWidgets('Initialize with initial category and switch category', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    Category category = createDefaultCategory();
    category.products = [product];
    Category category2 = category.clone()..name = "test";
    await tester.pumpWidget(wrapMaterial(
      widget: CategorySelector(
        initialCategory: category,
        categories: [category, category2],
        callback: (c) => category = c,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Category"), findsOneWidget);
    expect(find.text(DEFAULT_CATEGORY_NAME), findsOneWidget);

    await tester.tap(find.text(DEFAULT_CATEGORY_NAME));
    await tester.pumpAndSettle();

    await tester.tap(find.text("test").last);
    await tester.pumpAndSettle();

    expect(category.name, equals("test"));
  });

  testWidgets('Initialize with category and uncheck', (WidgetTester tester) async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    Category category = createDefaultCategory();
    category.products = [product];

    await tester.pumpWidget(wrapMaterial(
      widget: CategorySelector(
        initialCategory: category,
        categories: [category],
        callback: (c) => category = c,
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(category, isNull);
  });
}
