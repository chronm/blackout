import 'dart:core';

import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_machine/time_machine.dart';

int parseFromRegex(RegExpMatch match, int group, String character) {
  var result = match.group(group);
  return result != null ? int.parse(result.replaceFirst(character, "")) : 0;
}

Period periodFromISO8601String(String period) {
  period = period.toUpperCase();
  final regexp = RegExp(r"^P(?=\d+[YMWD])(\d+Y)?(\d+M)?(\d+W)?(\d+D)?(T(?=\d+[HMS])(\d+H)?(\d+M)?(\d+S)?)?$");
  if (!regexp.hasMatch(period)) {
    return null;
  }
  final match = regexp.firstMatch(period);

  final years = parseFromRegex(match, 1, "Y");
  final months = parseFromRegex(match, 2, "M");
  final weeks = parseFromRegex(match, 3, "W");
  final days = parseFromRegex(match, 4, "D");
  final hours = parseFromRegex(match, 6, "H");
  final minutes = parseFromRegex(match, 7, "M");
  final seconds = parseFromRegex(match, 8, "S");
  return Period(
    years: years,
    months: months,
    weeks: weeks,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

LocalDate LocalDateFromDateTime(DateTime dateTime) {
  return LocalDate.dateTime(dateTime).add(Period(hours: dateTime.timeZoneOffset.inHours));
}

extension LocalDateExtension on LocalDate {
  String prettyPrintShortDifference(BuildContext context) {
    DateTime now = LocalDate.today().toDateTimeUnspecified();
    DateTime other = this.toDateTimeUnspecified();

    if (now.day == other.day) {
      return S.of(context).GENERAL_EVENT_TODAY;
    }

    if (now.day - other.day == 1) {
      return S.of(context).GENERAL_EVENT_YESTERDAY;
    }
    if (now.day - other.day == -1) {
      return S.of(context).GENERAL_EVENT_TOMORROW;
    }
    if (Jiffy(now).diff(other, Units.WEEK) == 0) {
      return DateFormat.EEEE().format(other);
    }
    if (Jiffy(now).diff(other, Units.MONTH) == 0) {
      return S.of(context).GENERAL_EVENT_IN_WEEKS(Jiffy(now).diff(other, Units.WEEK).abs());
    }
    if (Jiffy(now).diff(other, Units.YEAR) == 0) {
      return S.of(context).GENERAL_EVENT_IN_MONTHS(Jiffy(now).diff(other, Units.MONTH).abs());
    }
    if (Jiffy(now).diff(other, Units.YEAR) < 0) {
      return S.of(context).GENERAL_EVENT_IN_OVER_A_YEAR;
    } else {
      return S.of(context).GENERAL_EVENT_OVER_A_YEAR_AGO;
    }
  }
}

extension PeriodExtension on Period {
  Duration toDuration() {
    int days = this.years * 365;
    days += this.months * 30;
    days += this.weeks * 7;
    days += this.days;

    return Duration(days: days, hours: this.hours, minutes: this.minutes, seconds: this.seconds, milliseconds: this.milliseconds, microseconds: this.microseconds);
  }

  String prettyPrint(BuildContext context) {
    if (this == null) {
      return "";
    }
    List<String> parts = [];
    if (this.years != 0) {
      parts.add(S.of(context).GENERAL_YEARS(this.years));
    }
    if (this.months != 0) {
      parts.add(S.of(context).GENERAL_MONTHS(this.months));
    }
    if (this.weeks != 0) {
      parts.add(S.of(context).GENERAL_WEEKS(this.weeks));
    }
    if (this.days != 0) {
      parts.add(S.of(context).GENERAL_DAYS(this.days));
    }
    if (this.hours != 0) {
      parts.add(S.of(context).GENERAL_HOURS(this.hours));
    }
    if (this.minutes != 0) {
      parts.add(S.of(context).GENERAL_MINUTES(this.minutes));
    }
    if (this.seconds != 0) {
      parts.add(S.of(context).GENERAL_SECONDS(this.seconds));
    }

    return parts.join(", ");
  }
}
