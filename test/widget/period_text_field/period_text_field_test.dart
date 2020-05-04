import 'package:Blackout/widget/period_text_field/period_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('return null if invalid input', (WidgetTester tester) async {
    Period period;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PeriodTextField(
          initialPeriod: Period.zero,
          callback: (_period) => period = _period,
        ),
      ),
    );
    await tester.pump();

    expect(period, isNull);
  });

  testWidgets('return period if valid input', (WidgetTester tester) async {
    Period period;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PeriodTextField(
          initialPeriod: Period.zero,
          callback: (_period) => period = _period,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "P1D");
    await tester.pumpAndSettle();

    expect(period.days, 1);
  });
}
