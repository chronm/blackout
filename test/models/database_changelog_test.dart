import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  Category category = createDefaultCategory()..id = DEFAULT_CATEGORY_ID;
  Product product = createDefaultProduct()..id = DEFAULT_PRODUCT_ID;
  Charge charge = createDefaultCharge()..id = DEFAULT_ITEM_ID;

  test('(ModelChange) new ModelChange for a category and product fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, category: category, product: product), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a category and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, category: category, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a product and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, product: product, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for a category, product and charge fails', () {
    expect(() => createDefaultModelChange(ModelChangeType.create, category: category, product: product, charge: charge), throwsAssertionError);
  });

  test('(ModelChange) new ModelChange for category succeedes', () {
    ModelChange changelog = createDefaultModelChange(ModelChangeType.create, category: category);

    expect(changelog.categoryId, equals(category.id));
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
