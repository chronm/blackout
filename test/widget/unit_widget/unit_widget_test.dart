import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('initial conversion into scientific', (WidgetTester tester) async {
    UnitEnum unit;
    double amount;
    bool checked;
    await tester.pumpWidget(
      wrapMaterial(
        UnitWidget(
          initialUnit: UnitEnum.weight,
          initialRefillLimit: 0.002,
          unitCallback: (u, a, c) {
            unit = u;
            amount = a;
            checked = c;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) {
      return widget is TextField && widget.controller.text == "2 g";
    }), findsOneWidget);

    await tester.enterText(find.byType(TextField), "2");
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) {
      return widget is TextField && widget.controller.text == "2";
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      return widget is Text && widget.data == "Error";
    }), findsOneWidget);
//
//    var test = await find.byWidgetPredicate((widget) => widget is DropdownMenuItem && widget.value == UnitEnum.weight);
//    var test2 = await find.byWidgetPredicate((widget) => widget is DropdownMenuItem && widget.value == UnitEnum.unitless);
//
//    await tester.tap(find.byWidgetPredicate((widget) => widget is DropdownButton));
//    await tester.pump();
//    await tester.press(test);
//    await tester.pump();
//
//    expect(unit, equals(UnitEnum.unitless));
//    expect(amount, equals(2));

    await tester.enterText(find.byType(TextField), "");
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) {
      return widget is Text && widget.data == "Error";
    }), findsOneWidget);
  });
}
