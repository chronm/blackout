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

  static m2(field, from) => "Disabled ${field} from ${from}";

  static m3(field, to) => "Enabled ${field} with ${to}";

  static m4(hours) => "${Intl.plural(hours, one: '1 hour', other: '${hours} hours')}";

  static m5(minutes) => "${Intl.plural(minutes, one: '1 minute', other: '${minutes} minutes')}";

  static m6(field, from, to) => "Changed ${field} from ${from} to ${to}";

  static m7(months) => "${Intl.plural(months, one: '1 month', other: '${months} months')}";

  static m8(seconds) => "${Intl.plural(seconds, one: '1 second', other: '${seconds} seconds')}";

  static m9(weeks) => "${Intl.plural(weeks, one: '1 week', other: '${weeks} weeks')}";

  static m10(years) => "${Intl.plural(years, one: '1 year', other: '${years} years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "_locale" : MessageLookupByLibrary.simpleMessage("en"),
    "available" : m0,
    "changes" : MessageLookupByLibrary.simpleMessage("Changes"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createHome" : MessageLookupByLibrary.simpleMessage("What should be the name of your household?"),
    "created" : MessageLookupByLibrary.simpleMessage("Created"),
    "days" : m1,
    "deleted" : MessageLookupByLibrary.simpleMessage("Deleted"),
    "disabledField" : m2,
    "enabledField" : m3,
    "finish" : MessageLookupByLibrary.simpleMessage("Finish"),
    "hours" : m4,
    "join" : MessageLookupByLibrary.simpleMessage("Join"),
    "joinHome" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "minutes" : m5,
    "modifiedField" : m6,
    "modifyCategory" : MessageLookupByLibrary.simpleMessage("Modify Category"),
    "months" : m7,
    "nameOfYourHousehold" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "plural" : MessageLookupByLibrary.simpleMessage("Plural"),
    "seconds" : m8,
    "setYourHome" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or create a new one?"),
    "setYourUsername" : MessageLookupByLibrary.simpleMessage("How do you want do be called. This will be used to identify you in your home."),
    "setup" : MessageLookupByLibrary.simpleMessage("Setup"),
    "singular" : MessageLookupByLibrary.simpleMessage("Singular"),
    "username" : MessageLookupByLibrary.simpleMessage("Username"),
    "weeks" : m9,
    "welcomeMessage" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "years" : m10
  };
}
