import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../blackout_test_base.dart';

void main() {
  test('(Title) Get the current title depending on amount', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    category.products = [product];
    product.charges = [charge];
    charge.changes = [change];

    expect(category.title, DEFAULT_CATEGORY_NAME);

    charge.changes = [change, change];

    expect(category.title, DEFAULT_CATEGORY_PLURAL_NAME);
  });

  test('(Title) Get current title depending on pluralName', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    category.products = [product];
    product.charges = [charge];
    charge.changes = [change, change];
    category.pluralName = null;

    expect(category.title, DEFAULT_CATEGORY_NAME);
  });

  test('(Clone) Clone category but instances are different', () async {
    Category category = createDefaultCategory();
    Category category2 = category.clone();

    expect(identical(category, category2), isFalse);
  });

  test('(ExpiredOrNotification) Any product is expired or notification should be thrown', () async {
    Category category = createDefaultCategory();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    category.products = [product];
    product.category = category;
    charge.product = product;
    product.charges = [charge];

    expect(category.expiredOrNotification, isTrue);

    charge.expirationDate = LocalDateTime.now().add(Period(days: 10));

    expect(category.expiredOrNotification, isFalse);
  });

  test('(TooFewAvailable) too few for category or for any product', () async {
    Category category = createDefaultCategory();
    category.refillLimit = 2.0;
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    product.category = category;
    charge.product = product;
    category.products = [product];
    product.charges = [charge];
    charge.changes = [change];

    expect(category.tooFewAvailable, isTrue);

    category.refillLimit = 1.0;
    charge.changes = [change, change];

    expect(category.tooFewAvailable, isFalse);
  });

  test('(IsValid) Check if a category has all required parameters', () async {
    Category category = createDefaultCategory();

    expect(category.isValid(), isTrue);

    category.unit = null;
    expect(category.isValid(), isFalse);
    category.unit = UnitEnum.unitless;

    category.name = null;
    expect(category.isValid(), isFalse);

    category.name = "";
    expect(category.isValid(), isFalse);
  });

  test('(==) Check if two categories are equal', () async {
    Category category = createDefaultCategory();
    Category category2 = createDefaultCategory();

    expect(category == category2, isTrue);

    category2.name = "";
    expect(category == category2, isFalse);
    category2.name = DEFAULT_CATEGORY_NAME;

    category2.pluralName = "";
    expect(category == category2, isFalse);
    category2.pluralName = DEFAULT_CATEGORY_PLURAL_NAME;

    category2.warnInterval = Period.zero;
    expect(category == category2, isFalse);
    category2.warnInterval = DEFAULT_CATEGORY_WARN_INTERVAL;

    category2.refillLimit = 0;
    expect(category == category2, isFalse);
  });

  test('(GetModifications) get all modifications between two categories', () async {
    Category category = createDefaultCategory();
    Category category2 = createDefaultCategory();

    expect(category.getModifications(category2).length, equals(0));

    category2.unit = UnitEnum.weight;
    expect(category.getModifications(category2).length, equals(1));
    category2.unit = UnitEnum.unitless;

    category2.name = "test";
    expect(category.getModifications(category2).length, equals(1));
    category2.name = DEFAULT_CATEGORY_NAME;

    category2.pluralName = "test";
    expect(category.getModifications(category2).length, equals(1));
    category2.pluralName = DEFAULT_CATEGORY_PLURAL_NAME;

    category2.warnInterval = Period.zero;
    expect(category.getModifications(category2).length, equals(1));
    category2.warnInterval = DEFAULT_CATEGORY_WARN_INTERVAL;

    category2.refillLimit = 2;
    expect(category.getModifications(category2).length, equals(1));
  });
}
