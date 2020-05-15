import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/widget/unit_widget/unit_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  testWidgets('Change unit', (WidgetTester tester) async {
    UnitEnum unit;
    await tester.pumpWidget(
      wrapMaterial(
        widget: UnitWidget(
          initialUnit: unit,
          callback: (u) => unit = u,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(UnitWidget));
    await tester.pumpAndSettle();
    await tester.tap(find.text("weight").last);
    await tester.pumpAndSettle();

    expect(unit, equals(UnitEnum.weight));
  });

  testWidgets('Static unit', (WidgetTester tester) async {
    UnitEnum unit = UnitEnum.unitless;
    await tester.pumpWidget(
      wrapMaterial(
        widget: UnitWidget(
          initialUnit: unit,
          callback: (u) => unit = u,
          static: true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('unitless'), findsOneWidget);
  });
}
