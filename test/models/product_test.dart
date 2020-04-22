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
