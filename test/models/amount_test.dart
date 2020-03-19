import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  test('', () async {
    Change change1 = createDefaultChange();
    Change change2 = createDefaultChange();
    Change change3 = createDefaultChange();
    Change change4 = createDefaultChange();
    Item item1 = createDefaultItem();
    Item item2 = createDefaultItem();
    Item item3 = createDefaultItem();
    Item item4 = createDefaultItem();
    item1.changes = [change1];
    item2.changes = [change2];
    item3.changes = [change3];
    item4.changes = [change4];
    Product product1 = createDefaultProduct();
    product1.items = [item1, item2];
    Product product2 = createDefaultProduct();
    product2.items = [item3, item4];
    Category category = createDefaultCategory();
    category.products = [product1, product2];

    expect(category.amount, equals(product1.amount + product2.amount));
    expect(product1.amount, equals(item1.amount + item2.amount));
    expect(product2.amount, equals(item3.amount + item4.amount));
    expect(item1.amount, equals(change1.value));
    expect(item2.amount, equals(change2.value));
    expect(item3.amount, equals(change3.value));
    expect(item4.amount, equals(change4.value));
  });
}
