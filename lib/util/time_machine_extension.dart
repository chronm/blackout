import 'dart:core';

import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
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

LocalDateTime localDateTimeFromDateTime(DateTime dateTime) {
  return LocalDateTime.dateTime(dateTime).add(Period(hours: dateTime.timeZoneOffset.inHours));
}

extension PeriodExtension on Period {
  String prettyPrint(BuildContext context) {
    if (this == null) {
      return "";
    }
    List<String> parts = [];
    if (this.years != 0) {
      parts.add(S.of(context).years(this.years));
    }
    if (this.months != 0) {
      parts.add(S.of(context).months(this.months));
    }
    if (this.weeks != 0) {
      parts.add(S.of(context).weeks(this.weeks));
    }
    if (this.days != 0) {
      parts.add(S.of(context).days(this.days));
    }
    if (this.hours != 0) {
      parts.add(S.of(context).hours(this.hours));
    }
    if (this.minutes != 0) {
      parts.add(S.of(context).minutes(this.minutes));
    }
    if (this.seconds != 0) {
      parts.add(S.of(context).seconds(this.seconds));
    }

    return parts.join(", ");
  }
}
