import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../blackout_test_base.dart';

void main() {
  test('(Title) Get the current title depending on amount', () async {
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    group.products = [product];
    product.charges = [charge];
    charge.changes = [change];

    expect(group.title, DEFAULT_CATEGORY_NAME);

    charge.changes = [change, change];

    expect(group.title, DEFAULT_CATEGORY_PLURAL_NAME);
  });

  test('(Title) Get current title depending on pluralName', () async {
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    group.products = [product];
    product.charges = [charge];
    charge.changes = [change, change];
    group.pluralName = null;

    expect(group.title, DEFAULT_CATEGORY_NAME);
  });

  test('(Clone) Clone group but instances are different', () async {
    Group group = createDefaultGroup();
    Group group2 = group.clone();

    expect(identical(group, group2), isFalse);
  });

  test('(ExpiredOrNotification) Any product is expired or notification should be thrown', () async {
    Group group = createDefaultGroup();
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    group.products = [product];
    product.group = group;
    charge.product = product;
    product.charges = [charge];

    expect(group.expiredOrNotification, isTrue);

    charge.expirationDate = LocalDateTime.now().add(Period(days: 10));

    expect(group.expiredOrNotification, isFalse);
  });

  test('(TooFewAvailable) too few for group or for any product', () async {
    Group group = createDefaultGroup();
    group.refillLimit = 2.0;
    Product product = createDefaultProduct();
    Charge charge = createDefaultCharge();
    Change change = createDefaultChange();
    product.group = group;
    charge.product = product;
    group.products = [product];
    product.charges = [charge];
    charge.changes = [change];

    expect(group.tooFewAvailable, isTrue);

    group.refillLimit = 1.0;
    charge.changes = [change, change];

    expect(group.tooFewAvailable, isFalse);
  });

  test('(IsValid) Check if a group has all required parameters', () async {
    Group group = createDefaultGroup();

    expect(group.isValid(), isTrue);

    group.unit = null;
    expect(group.isValid(), isFalse);
    group.unit = UnitEnum.unitless;

    group.name = null;
    expect(group.isValid(), isFalse);

    group.name = "";
    expect(group.isValid(), isFalse);
  });

  test('(==) Check if two groups are equal', () async {
    Group group = createDefaultGroup();
    Group group2 = createDefaultGroup();

    expect(group == group2, isTrue);

    group2.name = "";
    expect(group == group2, isFalse);
    group2.name = DEFAULT_CATEGORY_NAME;

    group2.pluralName = "";
    expect(group == group2, isFalse);
    group2.pluralName = DEFAULT_CATEGORY_PLURAL_NAME;

    group2.warnInterval = Period.zero;
    expect(group == group2, isFalse);
    group2.warnInterval = DEFAULT_CATEGORY_WARN_INTERVAL;

    group2.refillLimit = 0;
    expect(group == group2, isFalse);
  });

  test('(GetModifications) get all modifications between two groups', () async {
    Group group = createDefaultGroup();
    Group group2 = createDefaultGroup();

    expect(group.getModifications(group2).length, equals(0));

    group2.unit = UnitEnum.weight;
    expect(group.getModifications(group2).length, equals(1));
    group2.unit = UnitEnum.unitless;

    group2.name = "test";
    expect(group.getModifications(group2).length, equals(1));
    group2.name = DEFAULT_CATEGORY_NAME;

    group2.pluralName = "test";
    expect(group.getModifications(group2).length, equals(1));
    group2.pluralName = DEFAULT_CATEGORY_PLURAL_NAME;

    group2.warnInterval = Period.zero;
    expect(group.getModifications(group2).length, equals(1));
    group2.warnInterval = DEFAULT_CATEGORY_WARN_INTERVAL;

    group2.refillLimit = 2;
    expect(group.getModifications(group2).length, equals(1));
  });
}
