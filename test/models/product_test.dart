import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  test('(Title) get current title', () async {
    Product product = createDefaultProduct();

    expect(product.title, equals(DEFAULT_PRODUCT_DESCRIPTION));
  });

  test('(IsValid) return false if description null', () async {
    Product product = createDefaultProduct();
    product.description = null;

    expect(product.isValid(), isFalse);
  });

  test('(IsValid) return false if description empty', () async {
    Product product = createDefaultProduct();
    product.description = "";

    expect(product.isValid(), isFalse);
  });

  test('(IsValid) return true if description set', () async {
    expect(createDefaultProduct().isValid(), isTrue);
  });

  test('(TooFewAvailable) return false if refillLimit not set', () async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    product.refillLimit = null;

    expect(product.tooFewAvailable, isFalse);
  });

  test('(TooFewAvailable) return amount <= refillLimit = false if refillLimit set', () async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];

    expect(product.tooFewAvailable, isFalse);
  });

  test('(TooFewAvailable) return amount <= refillLimit = true if refillLimit set', () async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    product.refillLimit = 10;

    expect(product.tooFewAvailable, isTrue);
  });

  test('(ScientificAmount) get scientific amount with unit form category', () async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    Category category = createDefaultCategory();
    product.category = category;

    expect(product.scientificAmount, equals("1"));
  });

  test('(ScientificAmount) get scientific amount with unit form product', () async {
    Change change = createDefaultChange();
    Item item = createDefaultItem();
    item.changes = [change];
    Product product = createDefaultProduct();
    product.items = [item];
    product.unit = UnitEnum.unitless;
    product.category = null;

    expect(product.scientificAmount, equals("1"));
  });
}
