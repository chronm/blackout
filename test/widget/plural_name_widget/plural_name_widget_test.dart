import 'package:Blackout/widget/plural_name_widget/plural_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('enter text', (WidgetTester tester) async {
    String pluralName;
    bool checked;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PluralNameWidget(
          callback: (p, c) {
            pluralName = p;
            checked = c;
          },
          initialValue: "",
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), "pluralName");
    await tester.pumpAndSettle();

    expect(pluralName, equals("pluralName"));
    expect(checked, isTrue);
  });
}
