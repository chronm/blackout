import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('enter text', (WidgetTester tester) async {
    String pluralName;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PluralNameWidget(
          callback: (p) {
            pluralName = p;
          },
          initialValue: "",
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), "pluralName");
    await tester.pumpAndSettle();

    expect(pluralName, equals("pluralName"));
  });

  testWidgets('Uncheck', (WidgetTester tester) async {
    String pluralName;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PluralNameWidget(
          callback: (p) {
            pluralName = p;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));

    expect(pluralName, equals(""));
  });
}
