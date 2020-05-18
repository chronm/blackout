import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../blackout_test_base.dart';

void main() {
  testWidgets('(toLocalizedString) localized textrepresentation of a "create" modelchange', (WidgetTester tester) async {
    ModelChange change = ModelChange(user: createDefaultUser(), modificationDate: LocalDateTime.now(), modification: ModelChangeType.create, home: createDefaultHome(), categoryId: DEFAULT_CATEGORY_ID);
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    expect(change.toLocalizedString(context), equals("Created"));
  });

  testWidgets('(toLocalizedString) localized textrepresentation of a "modify" modelchange with changing field', (WidgetTester tester) async {
    ModelChange change = ModelChange(user: createDefaultUser(), modificationDate: LocalDateTime.now(), modification: ModelChangeType.modify, home: createDefaultHome(), categoryId: DEFAULT_CATEGORY_ID, modifications: [Modification(fieldName: "field", from: "from", to: "to")]);
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    expect(change.toLocalizedString(context), equals("Changed field from from to to"));
  });

  testWidgets('(toLocalizedString) localized textrepresentation of a "modify" modelchange with cleared field', (WidgetTester tester) async {
    ModelChange change = ModelChange(user: createDefaultUser(), modificationDate: LocalDateTime.now(), modification: ModelChangeType.modify, home: createDefaultHome(), categoryId: DEFAULT_CATEGORY_ID, modifications: [Modification(fieldName: "field", from: "from", to: "")]);
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    expect(change.toLocalizedString(context), equals("Disabled field (from)"));
  });

  testWidgets('(toLocalizedString) localized textrepresentation of a "modify" modelchange with enabled field', (WidgetTester tester) async {
    ModelChange change = ModelChange(user: createDefaultUser(), modificationDate: LocalDateTime.now(), modification: ModelChangeType.modify, home: createDefaultHome(), categoryId: DEFAULT_CATEGORY_ID, modifications: [Modification(fieldName: "field", from: "", to: "to")]);
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    expect(change.toLocalizedString(context), equals("Enabled field (to)"));
  });
}
