// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(amount) => "${amount} is not valid";

  static m1(amount) => "Available: ${amount}";

  static m2(create) => "${create} created";

  static m3(days) => "${Intl.plural(days, one: '1 day', other: '${days} days')}";

  static m4(field, from) => "Disabled ${field} (${from})";

  static m5(field, to) => "Enabled ${field} (${to})";

  static m6(time) => "expired ${time}";

  static m7(time) => "expires ${time}";

  static m8(hours) => "${Intl.plural(hours, one: '1 hour', other: '${hours} hours')}";

  static m9(months) => "${Intl.plural(months, one: 'in ${months} month', other: 'in ${months} months')}";

  static m10(weeks) => "${Intl.plural(weeks, one: 'in ${weeks} week', other: 'in ${weeks} weeks')}";

  static m11(minutes) => "${Intl.plural(minutes, one: '1 minute', other: '${minutes} minutes')}";

  static m12(field, from, to) => "Changed ${field} from ${from} to ${to}";

  static m13(months) => "${Intl.plural(months, one: '1 month', other: '${months} months')}";

  static m14(time) => "notify ${time}";

  static m15(seconds) => "${Intl.plural(seconds, one: '1 second', other: '${seconds} seconds')}";

  static m16(weeks) => "${Intl.plural(weeks, one: '1 week', other: '${weeks} weeks')}";

  static m17(years) => "${Intl.plural(years, one: '1 year', other: '${years} years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("en"),
    "amountCouldNotBeParsed" : m0,
    "available" : m1,
    "changes" : MessageLookupByLibrary.simpleMessage("Changes"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createHome" : MessageLookupByLibrary.simpleMessage("How do you want to call your household? You can change it later"),
    "created" : MessageLookupByLibrary.simpleMessage("Created"),
    "createdAt" : m2,
    "days" : m3,
    "deleted" : MessageLookupByLibrary.simpleMessage("Deleted"),
    "disabledField" : m4,
    "enabledField" : m5,
    "expired" : m6,
    "expires" : m7,
    "finish" : MessageLookupByLibrary.simpleMessage("Finish"),
    "future" : MessageLookupByLibrary.simpleMessage("far in the future"),
    "hours" : m8,
    "inMonths" : m9,
    "inWeeks" : m10,
    "join" : MessageLookupByLibrary.simpleMessage("Join"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "longAgo" : MessageLookupByLibrary.simpleMessage("very long ago"),
    "minimumAmount" : MessageLookupByLibrary.simpleMessage("Minimum amount"),
    "minutes" : m11,
    "modifiedField" : m12,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Modify Category"),
    "months" : m13,
    "nameMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name must not be empty"),
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "notify" : m14,
    "plural" : MessageLookupByLibrary.simpleMessage("If it has a plural form, enter here"),
    "seconds" : m15,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or create a new one?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("How do you want do be called. This will be the same for each household you are part of and is used to identify you e.g. when you add or remove items. You can change this later."),
    "setup" : MessageLookupByLibrary.simpleMessage("Setup"),
    "singular" : MessageLookupByLibrary.simpleMessage("What is the name of this category?"),
    "today" : MessageLookupByLibrary.simpleMessage("today"),
    "tomorrow" : MessageLookupByLibrary.simpleMessage("tomorrow"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "warnMe" : MessageLookupByLibrary.simpleMessage("Warn me before expiration"),
    "weeks" : m16,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m17,
    "yesterday" : MessageLookupByLibrary.simpleMessage("yesterday")
  };
}
