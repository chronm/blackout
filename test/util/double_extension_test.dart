import 'package:Blackout/util/double_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('expect 1 when 1.0', () {
    expect("1", 1.0.format());
  });

  test('expect 1.1 when 1.1', () {
    expect("1.1", 1.1.format());
  });

  test('expect 1.01 when 1.01', () {
    expect("1.01", 1.01.format());
  });
}
