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

  static m0(amount) => "Available: ${amount}";

  static m1(days) => "${Intl.plural(days, one: '1 day', other: '${days} days')}";

  static m2(hours) => "${Intl.plural(hours, one: '1 hour', other: '${hours} hours')}";

  static m3(minutes) => "${Intl.plural(minutes, one: '1 minute', other: '${minutes} minutes')}";

  static m4(months) => "${Intl.plural(months, one: '1 month', other: '${months} months')}";

  static m5(seconds) => "${Intl.plural(seconds, one: '1 second', other: '${seconds} seconds')}";

  static m6(weeks) => "${Intl.plural(weeks, one: '1 week', other: '${weeks} weeks')}";

  static m7(years) => "${Intl.plural(years, one: '1 year', other: '${years} years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("en"),
    "available" : m0,
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createHome" : MessageLookupByLibrary.simpleMessage("What should be the name of your household?"),
    "days" : m1,
    "finish" : MessageLookupByLibrary.simpleMessage("Finish"),
    "hours" : m2,
    "join" : MessageLookupByLibrary.simpleMessage("Join"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "minutes" : m3,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Modify Category"),
    "months" : m4,
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "plural" : MessageLookupByLibrary.simpleMessage("Plural"),
    "seconds" : m5,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or create a new one?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("How do you want do be called. This will be used to identify you in your home."),
    "setup" : MessageLookupByLibrary.simpleMessage("Setup"),
    "singular" : MessageLookupByLibrary.simpleMessage("Singular"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "weeks" : m6,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m7
  };
}
