import 'package:Blackout/widget/name_text_field/name_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('callback null if empty input', (WidgetTester tester) async {
    String name;
    await tester.pumpWidget(
      wrapMaterial(
        widget: NameTextField(
          initialValue: "text",
          callback: (value) => name = value,
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), "");
    await tester.pumpAndSettle();

    expect(name, isNull);
  });

  testWidgets('callback when changed input', (WidgetTester tester) async {
    String name;
    await tester.pumpWidget(
      wrapMaterial(
        widget: NameTextField(
          initialValue: "name",
          callback: (value) => name = value,
        ),
      ),
    );
    await tester.pump();
    await tester.enterText(find.byType(TextField), "othername");
    await tester.pumpAndSettle();
    expect(name, equals("othername"));
  });
}
