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

  static m0(amount, date) => "Added ${amount} ${date}";

  static m1(amount) => "${amount} is not valid";

  static m2(amount) => "Available: ${amount}";

  static m3(create) => "created ${create}";

  static m4(days) => "${Intl.plural(days, one: '1 day', other: '${days} days')}";

  static m5(field, from) => "Disabled ${field} (${from})";

  static m6(field, to) => "Enabled ${field} (${to})";

  static m7(expirationDate) => "${expirationDate} is not valid";

  static m8(time) => "expired ${time}";

  static m9(time) => "expires ${time}";

  static m10(hours) => "${Intl.plural(hours, one: '1 hour', other: '${hours} hours')}";

  static m11(months) => "${Intl.plural(months, one: 'in ${months} month', other: 'in ${months} months')}";

  static m12(weeks) => "${Intl.plural(weeks, one: 'in ${weeks} week', other: 'in ${weeks} weeks')}";

  static m13(minutes) => "${Intl.plural(minutes, one: '1 minute', other: '${minutes} minutes')}";

  static m14(field, from, to) => "Changed ${field} from ${from} to ${to}";

  static m15(months) => "${Intl.plural(months, one: '1 month', other: '${months} months')}";

  static m16(notificationDate) => "${notificationDate} is not valid";

  static m17(time) => "notify ${time}";

  static m18(amount, date) => "Took ${amount} ${date}";

  static m19(seconds) => "${Intl.plural(seconds, one: '1 second', other: '${seconds} seconds')}";

  static m20(weeks) => "${Intl.plural(weeks, one: '1 week', other: '${weeks} weeks')}";

  static m21(years) => "${Intl.plural(years, one: '1 year', other: '${years} years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("en"),
    "added" : m0,
    "amountCouldNotBeParsed" : m1,
    "available" : m2,
    "changes" : MessageLookupByLibrary.simpleMessage("Changes"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createHome" : MessageLookupByLibrary.simpleMessage("How do you want to call your household? You can change it later"),
    "created" : MessageLookupByLibrary.simpleMessage("Created"),
    "createdAt" : m3,
    "days" : m4,
    "description" : MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Description must not be empty"),
    "disabledField" : m5,
    "ean" : MessageLookupByLibrary.simpleMessage("Product code (ean)"),
    "enabledField" : m6,
    "expirationDate" : MessageLookupByLibrary.simpleMessage("Best before"),
    "expirationDateCouldNotBeParsed" : m7,
    "expired" : m8,
    "expires" : m9,
    "finish" : MessageLookupByLibrary.simpleMessage("Finish"),
    "future" : MessageLookupByLibrary.simpleMessage("far in the future"),
    "hours" : m10,
    "inMonths" : m11,
    "inWeeks" : m12,
    "join" : MessageLookupByLibrary.simpleMessage("Join"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "longAgo" : MessageLookupByLibrary.simpleMessage("very long ago"),
    "minimumAmount" : MessageLookupByLibrary.simpleMessage("Minimum amount"),
    "minutes" : m13,
    "modifiedField" : m14,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Modify Category"),
    "modifyCharge" : MessageLookupByLibrary.simpleMessage("Modify Charge"),
    "modifyProduct" : MessageLookupByLibrary.simpleMessage("Modify Product"),
    "months" : m15,
    "nameMustNotBeEmpty" : MessageLookupByLibrary.simpleMessage("Name must not be empty"),
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "notificationDate" : MessageLookupByLibrary.simpleMessage("Notify at"),
    "notificationDateCouldNotBeParsed" : m16,
    "notify" : m17,
    "plural" : MessageLookupByLibrary.simpleMessage("If it has a plural form, enter here"),
    "removed" : m18,
    "seconds" : m19,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or create a new one?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("How do you want do be called. This will be the same for each household you are part of and is used to identify you e.g. when you add or remove charges. You can change this later."),
    "setup" : MessageLookupByLibrary.simpleMessage("Setup"),
    "singular" : MessageLookupByLibrary.simpleMessage("What is the name of this category?"),
    "today" : MessageLookupByLibrary.simpleMessage("today"),
    "tomorrow" : MessageLookupByLibrary.simpleMessage("tomorrow"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "warnMe" : MessageLookupByLibrary.simpleMessage("Warn me before expiration"),
    "weeks" : m20,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m21,
    "yesterday" : MessageLookupByLibrary.simpleMessage("yesterday")
  };
}
