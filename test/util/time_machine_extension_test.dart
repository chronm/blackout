import 'package:Blackout/util/time_machine_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:time_machine/time_machine.dart';

import '../blackout_test_base.dart';

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
    expect(periodFromISO8601String("asdf"), isNull);
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

  testWidgets('PrettyPrint a time_machine period', (WidgetTester tester) async {
    Period period = periodFromISO8601String("P1Y2M3W4DT5H6M7S");
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    expect(period.prettyPrint(context), equals("1 year, 2 months, 3 weeks, 4 days, 5 hours, 6 minutes, 7 seconds"));
  });

  test('Period to duration', () {
    Period period = Period(years: 1, months: 2, weeks: 3, days: 4, hours: 5, minutes: 6, seconds: 7);

    Duration duration = period.toDuration();

    expect(duration, equals(Duration(days: 450, hours: 5, minutes: 6, seconds: 7)));
  });

  testWidgets('Pretty print short difference between LocalDateTime and now', (WidgetTester tester) async {
    BuildContext context = await DEFAULT_BUILD_CONTEXT(tester);

    LocalDateTime then = LocalDateTime.now();
    expect(then.prettyPrintShortDifference(context), "today");

    then = LocalDateTime.now().subtractDays(1);
    expect(then.prettyPrintShortDifference(context), "yesterday");

    then = LocalDateTime.now().subtractDays(2);
    expect(then.prettyPrintShortDifference(context), then.dayOfWeek.toString());

    then = LocalDateTime.now().subtractWeeks(1);
    expect(then.prettyPrintShortDifference(context), "this month");

    then = LocalDateTime.now().subtractMonths(1);
    expect(then.prettyPrintShortDifference(context), "this year");

    then = LocalDateTime.now().subtractYears(1);
    expect(then.prettyPrintShortDifference(context), "very long ago");
  });
}
