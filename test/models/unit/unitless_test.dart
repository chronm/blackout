import 'package:Blackout/models/unit/unitless.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('(Unitless.parseInput) parse unitless input', () async {
    double value = Unitless().parseInput("2");

    expect(value, equals(2));
  });
}
