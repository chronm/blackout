import 'package:Blackout/widget/period_widget/period_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('Initialize with null', (WidgetTester tester) async {
    Period period = null;
    bool error;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PeriodWidget(
          initialPeriod: period,
          callback: (p, e) {
            period = p;
            error = e;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Warn me before expiration'), findsOneWidget);

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(error, isTrue);
  });

  testWidgets('Initialize with period', (WidgetTester tester) async {
    Period period = DEFAULT_PERIOD_UNTIL_EXPIRATION;
    bool error;
    await tester.pumpWidget(
      wrapMaterial(
        widget: PeriodWidget(
          initialPeriod: period,
          callback: (p, e) {
            period = p;
            error = e;
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1 week'), findsOneWidget);
  
    await tester.enterText(find.byType(TextField), 'P1');
    await tester.pumpAndSettle();

    expect(error, isTrue);
    expect(find.text('Error'), findsOneWidget);
  });
}
