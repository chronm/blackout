import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

void main() {
  test('(PeriodFromISO8601String)', () {
    Period period = periodFromISO8601String('P1Y2M3DT4H5M6S');

    expect(period.years, equals(1));
    expect(period.months, equals(2));
    expect(period.days, equals(3));
    expect(period.hours, equals(4));
    expect(period.minutes, equals(5));
    expect(period.seconds, equals(6));
  });

  test('(PeriodFromISO8601String) throw ArgumentError when String is not in ISO8601 format', () {
    expect(() => periodFromISO8601String('asdf'), throwsArgumentError);
  });

  test('(LocalDateTimeFromDateTime)', () {
    LocalDateTime localDateTime = localDateTimeFromDateTime(DateTime(2020, 3, 24, 12, 49, 0));

    expect(localDateTime.year, equals(2020));
    expect(localDateTime.monthOfYear, equals(3));
    expect(localDateTime.dayOfMonth, equals(24));
    expect(localDateTime.hourOfDay, equals(12));
    expect(localDateTime.minuteOfHour, equals(49));
    expect(localDateTime.secondOfMinute, equals(0));
  });
}
