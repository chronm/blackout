import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('toggle checkbox', (WidgetTester tester) async {
    String value = "";
    bool checked = false;
    await tester.pumpWidget(
      wrapMaterial(
        CheckedTextField(
          initialValue: value,
          initialChecked: checked,
          callback: (_value, _checked) {
            value = _value;
            checked = _checked;
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(value, "");
    expect(checked, isTrue);
  });

  testWidgets('enter text when not checked', (WidgetTester tester) async {
    String value = "";
    bool checked = false;
    await tester.pumpWidget(
      wrapMaterial(
        CheckedTextField(
          initialValue: value,
          initialChecked: checked,
          callback: (_value, _checked) {
            value = _value;
            checked = _checked;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "newText");

    await tester.pumpAndSettle();

    expect(value, "newText");
    expect(checked, isFalse);
  }, skip: true);
}
