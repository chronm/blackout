import 'dart:core';

import 'package:time_machine/time_machine.dart';

//Duration durationFromISO8601(String duration) {
//  if (!RegExp(r"^P((\d+W)?(\d+D)?)(T(\d+H)?(\d+M)?(\d+S)?)?$").hasMatch(duration)) {
//    throw ArgumentError("String does not follow correct format");
//  }
//  final weeks = _parseTime(duration, "W");
//  final days = _parseTime(duration, "D");
//  final hours = _parseTime(duration, "H");
//  final minutes = _parseTime(duration, "M");
//  final seconds = _parseTime(duration, "S");
//  return Duration(
//    days: days + (weeks * 7),
//    hours: hours,
//    minutes: minutes,
//    seconds: seconds,
//  );
//}

/**
 * Private helper method for extracting a time value from the ISO8601 string.
 */
int _parseTime(String duration, String timeUnit, bool time) {
  var timeMatch;
  if (time) {
    timeMatch = RegExp(r"T(.*)((\d+)" + timeUnit + r"(\.*))").firstMatch(duration);
  } else {
    timeMatch = RegExp(r"(\d+" + timeUnit + r")").firstMatch(duration);
  }
  if (timeMatch == null) {
    return 0;
  }
  var timeString;
  if (time) {
    timeString = timeMatch.group(2);
  } else {
    timeString = timeMatch.group(1);
  }
  return int.parse(timeString.substring(0, timeString.length - 1));
}

Period periodFromISO8601String(String period) {
  if (!RegExp(r"^P((\d+Y)?(\d+M)?(\d+D)?)(T(\d+H)?(\d+M)?(\d+S)?)?$").hasMatch(period)) {
    throw ArgumentError("String does not follow correct format");
  }
  final years = _parseTime(period, "Y", false);
  final months = _parseTime(period, "M", false);
  final days = _parseTime(period, "D", false);
  final hours = _parseTime(period, "H", true);
  final minutes = _parseTime(period, "M", true);
  final seconds = _parseTime(period, "S", true);
  return Period(
    years: years,
    months: months,
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

LocalDateTime localDateTimeFromDateTime(DateTime dateTime) {
  return LocalDateTime.dateTime(dateTime).add(Period(hours: dateTime.timeZoneOffset.inHours));
}
