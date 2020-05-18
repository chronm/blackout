import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  test('', () async {
    Change change1 = createDefaultChange();
    Change change2 = createDefaultChange();
    Change change3 = createDefaultChange();
    Change change4 = createDefaultChange();
    Charge charge1 = createDefaultCharge();
    Charge charge2 = createDefaultCharge();
    Charge charge3 = createDefaultCharge();
    Charge charge4 = createDefaultCharge();
    charge1.changes = [change1];
    charge2.changes = [change2];
    charge3.changes = [change3];
    charge4.changes = [change4];
    Product product1 = createDefaultProduct();
    product1.charges = [charge1, charge2];
    Product product2 = createDefaultProduct();
    product2.charges = [charge3, charge4];
    Category category = createDefaultCategory();
    category.products = [product1, product2];

    expect(category.amount, equals(product1.amount + product2.amount));
    expect(product1.amount, equals(charge1.amount + charge2.amount));
    expect(product2.amount, equals(charge3.amount + charge4.amount));
    expect(charge1.amount, equals(change1.value));
    expect(charge2.amount, equals(change2.value));
    expect(charge3.amount, equals(change3.value));
    expect(charge4.amount, equals(change4.value));
  });
}
