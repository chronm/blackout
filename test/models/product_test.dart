import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
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
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    product.refillLimit = null;

    expect(product.tooFewAvailable, isFalse);
  });

  test('(TooFewAvailable) return amount <= refillLimit = false if refillLimit set', () async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];

    expect(product.tooFewAvailable, isFalse);
  });

  test('(TooFewAvailable) return amount <= refillLimit = true if refillLimit set', () async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    product.refillLimit = 10;

    expect(product.tooFewAvailable, isTrue);
  });

  test('(ScientificAmount) get scientific amount with unit form category', () async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    Category category = createDefaultCategory();
    product.category = category;

    expect(product.subtitle, equals("1"));
  });

  test('(ScientificAmount) get scientific amount with unit form product', () async {
    Change change = createDefaultChange();
    Charge charge = createDefaultCharge();
    charge.changes = [change];
    Product product = createDefaultProduct();
    product.charges = [charge];
    product.unit = UnitEnum.unitless;
    product.category = null;

    expect(product.subtitle, equals("1"));
  });

  test('(GetModifications) get all modifications between two products', () async {
    Product product = createDefaultProduct();
    product.refillLimit = 2.0;
    Product product2 = createDefaultProduct();
    product2.refillLimit = 2.0;

    expect(product.getModifications(product2).length, equals(0));

    product2.ean = "test";
    expect(product.getModifications(product2).length, equals(1));
    product2.ean = DEFAULT_PRODUCT_EAN;

    product2.description = "test";
    expect(product.getModifications(product2).length, equals(1));
    product2.description = DEFAULT_PRODUCT_DESCRIPTION;

    product2.refillLimit = 0;
    expect(product.getModifications(product2).length, equals(1));
  });

  test('(==) Check if two products are equal', () async {
    Product product = createDefaultProduct();
    Product product2 = createDefaultProduct();

    expect(product == product2, isTrue);

    product2.ean = "test";
    expect(product == product2, isFalse);
    product2.ean = DEFAULT_PRODUCT_EAN;

    product2.description = "test";
    expect(product == product2, isFalse);
    product2.description = DEFAULT_PRODUCT_DESCRIPTION;

    product2.refillLimit = 0;
    expect(product == product2, isFalse);
  });
}
