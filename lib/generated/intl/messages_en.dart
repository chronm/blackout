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

  static m1(amount, date) => "Took ${amount} ${date}";

  static m2(amount) => "Available: ${amount}";

  static m3(days) => "${Intl.plural(days, zero: '', one: '1 day', other: '${days} days')}";

  static m4(months) => "${Intl.plural(months, zero: '', one: 'in 1 month', other: 'in ${months} months')}";

  static m5(weeks) => "${Intl.plural(weeks, zero: '', one: 'in 1 week', other: 'in ${weeks} weeks')}";

  static m6(expirationDate) => "expired ${expirationDate}";

  static m7(expirationDate) => "Expires at ${expirationDate}";

  static m8(interval) => "expires ${interval}";

  static m9(hours) => "${Intl.plural(hours, zero: '', one: '1 hour', other: '${hours} hours')}";

  static m10(amount) => "Less than ${amount} available";

  static m11(minutes) => "${Intl.plural(minutes, zero: '', one: '1 minute', other: '${minutes} minutes')}";

  static m12(months) => "${Intl.plural(months, zero: '', one: '1 month', other: '${months} months')}";

  static m13(notificationDate) => "Notify at ${notificationDate}";

  static m14(seconds) => "${Intl.plural(seconds, zero: '', one: '1 second', other: '${seconds} seconds')}";

  static m15(weeks) => "${Intl.plural(weeks, zero: '', one: '1 week', other: '${weeks} weeks')}";

  static m16(years) => "${Intl.plural(years, zero: '', one: '1 year', other: '${years} years')}";

  static m17(field, from) => "Disabled ${field} (${from})";

  static m18(field, to) => "Enabled ${field} (${to})";

  static m19(field, from, to) => "Changed ${field} from ${from} to ${to}";

  static m20(creationDate) => "created ${creationDate}";

  static m21(amount) => "${amount} is not valid";

  static m22(expirationDate) => "${expirationDate} is not valid";

  static m23(notificationDate) => "${notificationDate} is not valid";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "CHANGES" : MessageLookupByLibrary.simpleMessage("Changes"),
    "CHANGE_ADDED" : m0,
    "CHANGE_TOOK" : m1,
    "GENERAL_AMOUNT_AVAILABLE" : m2,
    "GENERAL_DAYS" : m3,
    "GENERAL_EVENT_IN_MONTHS" : m4,
    "GENERAL_EVENT_IN_OVER_A_YEAR" : MessageLookupByLibrary.simpleMessage("in over one year"),
    "GENERAL_EVENT_IN_WEEKS" : m5,
    "GENERAL_EVENT_OVER_A_YEAR_AGO" : MessageLookupByLibrary.simpleMessage("over one year ago"),
    "GENERAL_EVENT_TODAY" : MessageLookupByLibrary.simpleMessage("today"),
    "GENERAL_EVENT_TOMORROW" : MessageLookupByLibrary.simpleMessage("tomorrow"),
    "GENERAL_EVENT_YESTERDAY" : MessageLookupByLibrary.simpleMessage("yesterday"),
    "GENERAL_EXPIRED_AGO" : m6,
    "GENERAL_EXPIRES_AT" : m7,
    "GENERAL_EXPIRES_IN" : m8,
    "GENERAL_HOURS" : m9,
    "GENERAL_LESS_THAN_AVAILABLE" : m10,
    "GENERAL_MINUTES" : m11,
    "GENERAL_MONTHS" : m12,
    "GENERAL_NOTIFY_AT" : m13,
    "GENERAL_SAVE" : MessageLookupByLibrary.simpleMessage("Save"),
    "GENERAL_SEARCH" : MessageLookupByLibrary.simpleMessage("Search"),
    "GENERAL_SECONDS" : m14,
    "GENERAL_WEEKS" : m15,
    "GENERAL_YEARS" : m16,
    "GROUP_BEST_BEFORE" : MessageLookupByLibrary.simpleMessage("Warn me before expiration"),
    "GROUP_MINIMUM_AMOUNT" : MessageLookupByLibrary.simpleMessage("Minimum amount"),
    "GROUP_NAME" : MessageLookupByLibrary.simpleMessage("Name of this group"),
    "GROUP_NO_PRODUCTS" : MessageLookupByLibrary.simpleMessage("No products"),
    "GROUP_PLURAL_NAME" : MessageLookupByLibrary.simpleMessage("Plural form of name"),
    "MODEL_CHANGE_CREATED" : MessageLookupByLibrary.simpleMessage("Created"),
    "MODEL_CHANGE_FIELD_DISABLED" : m17,
    "MODEL_CHANGE_FIELD_ENABLED" : m18,
    "MODEL_CHANGE_FIELD_MODIFIED" : m19,
    "PRODUCTS" : MessageLookupByLibrary.simpleMessage("Products"),
    "PRODUCT_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Description"),
    "PRODUCT_EAN" : MessageLookupByLibrary.simpleMessage("Product code"),
    "SETUP_CREATE_HOME" : MessageLookupByLibrary.simpleMessage("Create"),
    "SETUP_CREATE_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("How do you want to call your household? You can change it later"),
    "SETUP_FINISH" : MessageLookupByLibrary.simpleMessage("Finish"),
    "SETUP_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or create a new one?"),
    "SETUP_HOME_NAME" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "SETUP_JOIN_HOME" : MessageLookupByLibrary.simpleMessage("Join"),
    "SETUP_JOIN_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "SETUP_USERNAME" : MessageLookupByLibrary.simpleMessage("Username"),
    "SETUP_USERNAME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("How do you want do be called. This will be the same for each household you are part of and is used to identify you e.g. when you add or remove charges. You can change this later."),
    "SETUP_WELCOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam"),
    "UNITS" : MessageLookupByLibrary.simpleMessage("Charges"),
    "UNIT_CREATED_AT" : m20,
    "UNIT_EXPIRATION_DATE" : MessageLookupByLibrary.simpleMessage("Best before"),
    "UNIT_NOTIFICATION_DATE" : MessageLookupByLibrary.simpleMessage("Notify at"),
    "WARN_AMOUNT_COULD_NOT_BE_PARSED" : m21,
    "WARN_DESCRIPTION_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Description must not be empty"),
    "WARN_EAN_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Product code must not be empty"),
    "WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED" : m22,
    "WARN_NAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Name must not be empty"),
    "WARN_NOTIFICATION_DATE_COULD_NOT_BE_PARSED" : m23
  };
}
