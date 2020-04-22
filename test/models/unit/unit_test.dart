import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/unit/unitless.dart';
import 'package:Blackout/models/unit/weight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('(Amount.fromInput) try to parse "2 g" weight', () async {
    Amount amount = Amount.fromInput("2 g", UnitEnum.weight);

    expect(amount.value, equals(2));
    expect(amount.unit, isA<G>());
    expect(amount.toString(), equals("2 g"));
  });

  test('(Amount.fromSi) create Amount with 2.0 and weight', () async {
    Amount amount = Amount.fromSi(2.0, UnitEnum.weight);

    expect(amount.value, equals(2));
    expect(amount.unit, isA<Kg>());
    expect(amount.toString(), equals("2 kg"));
  });

  test('(Unit.fromInput) get weight if UnitEnum.weight', () async {
    expect(Unit.fromInput("2 g", UnitEnum.weight), isA<G>());
  });

  test('(Unit.fromSi) get weight if UnitEnum.weight', () async {
    expect(Unit.fromSi(UnitEnum.weight), isA<Kg>());
  });

  test('(Unit.fromInput) get unitless if UnitEnum.unitless', () async {
    expect(Unit.fromInput("2", UnitEnum.unitless), isA<Unitless>());
  });

  test('(Unit.fromSi) get unitless if UnitEnum.unitless', () async {
    expect(Unit.fromSi(UnitEnum.unitless), isA<Unitless>());
  });

  test('(UnitConverter.toSi) convert amount to si unit', () async {
    Amount amount = Amount(2, G());
    amount = UnitConverter.toSi(amount);

    expect(amount.value, equals(0.002));
    expect(amount.unit, isA<Kg>());
  });

  test('(UnitConverter.toScientific) expect "2 g" for 0,002 kg', () async {
    Amount amount = Amount(0.002, Kg());
    amount = UnitConverter.toScientific(amount);

    expect(amount.value, equals(2));
    expect(amount.unit, isA<G>());
  });
}
