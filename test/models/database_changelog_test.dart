import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  Group group = createDefaultGroup()..id = DEFAULT_CATEGORY_ID;
  Product product = createDefaultProduct()..id = DEFAULT_PRODUCT_ID;
  Charge charge = createDefaultCharge()..id = DEFAULT_ITEM_ID;

  test('(ModelChange) new ModelChange for a group and product fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, group: group, product: product), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a group and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, group: group, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a product and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, product: product, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a group, product and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, group: group, product: product, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for group succeedes', () {
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, group: group);

    expect(changelog.groupId, equals(group.id));
  });

  test('(ModelChange) new ModelChange for product succeedes', () {
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, product: product);

    expect(changelog.productId, equals(product.id));
  });

  test('(ModelChange) new ModelChange for charge succeedes', () {
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, charge: charge);

    expect(changelog.chargeId, equals(charge.id));
  });
}
