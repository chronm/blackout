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

LocalDateTime localDateTimeFromDateTime(DateTime dateTime) {
  return LocalDateTime.dateTime(dateTime).add(Period(hours: dateTime.timeZoneOffset.inHours));
}

extension LocalDateTimeExtension on LocalDateTime {
  String prettyPrintShortDifference(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;

    DateTime now = LocalDateTime.now().toDateTimeLocal();
    DateTime other = this.toDateTimeLocal();

    if (now.day == other.day) {
      return S.of(context).today;
    }

    if (now.day - other.day == 1) {
      return S.of(context).yesterday;
    }
    if (now.day - other.day == -1) {
      return S.of(context).tomorrow;
    }
    if (Jiffy(now).diff(other, Units.WEEK) == 0) {
      return DateFormat('EEEE', languageCode).format(other);
    }
    if (Jiffy(now).diff(other, Units.MONTH) == 0) {
      return S.of(context).inWeeks(Jiffy(now).diff(other, Units.WEEK).abs());
    }
    if (Jiffy(now).diff(other, Units.YEAR) == 0) {
      return S.of(context).inMonths(Jiffy(now).diff(other, Units.MONTH).abs());
    }
    if (Jiffy(now).diff(other, Units.YEAR) < 0) {
      return S.of(context).future;
    } else {
      return S.of(context).longAgo;
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
