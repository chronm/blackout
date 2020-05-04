import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('description', (WidgetTester tester) async {
    Period period;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PeriodWidget(
          callback: (p) => period = p,
          initialPeriod: Period.zero,
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), "P1D");
    await tester.pumpAndSettle();

    expect(period.days, equals(1));

    expect(find.byWidgetPredicate((widget) {
      return widget is Text && widget.data == "1 day";
    }), findsOneWidget);

    expect(find.byWidgetPredicate((widget) {
      return widget is TextField && widget.controller.text == "P1D";
    }), findsOneWidget);
  });
}
