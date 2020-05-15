import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/widget/refill_limit_widget/refill_limit_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {

  testWidgets('Initialize with null', (WidgetTester tester) async {
    double amount;
    bool error;
    await tester.pumpWidget(
      wrapMaterial(
        widget: RefillLimitWidget(
          initialUnit: UnitEnum.unitless,
          initialRefillLimit: amount,
          callback: (a, e) {
            amount = a;
            error = e;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Minimum amount'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(error, isTrue);
  });

  testWidgets('Initialize with amount', (WidgetTester tester) async {
    double amount = 2.0;
    bool error;
    await tester.pumpWidget(
      wrapMaterial(
        widget: RefillLimitWidget(
          initialUnit: UnitEnum.weight,
          initialRefillLimit: amount,
          callback: (a, e) {
            amount = a;
            error = e;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Minimum amount'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '1');
    await tester.pumpAndSettle();

    expect(error, isTrue);
  });
}
