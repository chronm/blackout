import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:time_machine/time_machine.dart';

import '../generated/l10n.dart';

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

LocalDate localDateFromDateTime(DateTime dateTime) {
  return LocalDate.dateTime(dateTime);
}

extension LocalDateExtension on LocalDate {
  String prettyPrintShortDifference(BuildContext context) {
    var now = LocalDate.today().toDateTimeUnspecified();
    var other = toDateTimeUnspecified();

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
    var days = years * 365;
    days += months * 30;
    days += weeks * 7;
    days += days;

    return Duration(days: days, hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds, microseconds: microseconds);
  }

  String prettyPrint(BuildContext context) {
    if (this == null) {
      return "";
    }
    var parts = <String>[];
    if (years != 0) {
      parts.add(S.of(context).GENERAL_YEARS(years));
    }
    if (months != 0) {
      parts.add(S.of(context).GENERAL_MONTHS(months));
    }
    if (weeks != 0) {
      parts.add(S.of(context).GENERAL_WEEKS(weeks));
    }
    if (days != 0) {
      parts.add(S.of(context).GENERAL_DAYS(days));
    }
    if (hours != 0) {
      parts.add(S.of(context).GENERAL_HOURS(hours));
    }
    if (minutes != 0) {
      parts.add(S.of(context).GENERAL_MINUTES(minutes));
    }
    if (seconds != 0) {
      parts.add(S.of(context).GENERAL_SECONDS(seconds));
    }

    return parts.join(", ");
  }
}
