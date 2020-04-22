import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/unit/weight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('(Weight.parseInput) get unit from symbol', () async {
    String input = "2t";
    Unit unit = Weight.parseSymbol(input);
    double amount = unit.parseInput(input);

    expect(unit, isA<T>());
    expect(amount, equals(2));

    input = "2 kg";
    unit = Weight.parseSymbol(input);
    amount = unit.parseInput(input);

    expect(unit, isA<Kg>());
    expect(amount, equals(2));

    input = "2  g";
    unit = Weight.parseSymbol(input);
    amount = unit.parseInput(input);

    expect(unit, isA<G>());
    expect(amount, equals(2));

    input = "2   mg";
    unit = Weight.parseSymbol(input);
    amount = unit.parseInput(input);

    expect(unit, isA<Mg>());
    expect(amount, equals(2));
  });
}
