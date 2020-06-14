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

  static m0(amount, date) => "added ${amount} ${date}";

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
    "CHANGELOG" : MessageLookupByLibrary.simpleMessage("Changelog"),
    "CHANGELOG_OKAY" : MessageLookupByLibrary.simpleMessage("Okay"),
    "CHANGES" : MessageLookupByLibrary.simpleMessage("Changes"),
    "CHANGE_ADDED" : m0,
    "CHANGE_TOOK" : m1,
    "DIALOG_ACCEPT_BUTTON" : MessageLookupByLibrary.simpleMessage("Accept"),
    "DIALOG_ADD_TO_CHARGE" : MessageLookupByLibrary.simpleMessage("Add to charge"),
    "DIALOG_CANCEL_BUTTON" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "DIALOG_TAKE_FROM_CHARGE" : MessageLookupByLibrary.simpleMessage("Take from charge"),
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
    "GENERAL_NOTHING_HERE" : MessageLookupByLibrary.simpleMessage("Nothing here"),
    "GENERAL_NOTIFY_AT" : m13,
    "GENERAL_SAVE" : MessageLookupByLibrary.simpleMessage("Save"),
    "GENERAL_SEARCH" : MessageLookupByLibrary.simpleMessage("Search ..."),
    "GENERAL_SECONDS" : m14,
    "GENERAL_WEEKS" : m15,
    "GENERAL_YEARS" : m16,
    "GROUP_BEST_BEFORE" : MessageLookupByLibrary.simpleMessage("Warn me before expiration"),
    "GROUP_MINIMUM_AMOUNT" : MessageLookupByLibrary.simpleMessage("Minimum amount"),
    "GROUP_NAME" : MessageLookupByLibrary.simpleMessage("Name of this group"),
    "GROUP_PLURAL_NAME" : MessageLookupByLibrary.simpleMessage("Plural form of name"),
    "HOME_PRODUCTS_AND_GROUPS" : MessageLookupByLibrary.simpleMessage("Products and Groups"),
    "MAIN_IMPORT_DATABASE" : MessageLookupByLibrary.simpleMessage("I found a backup. Should I import it or do you want to ignore it? If you ignore it, it will be deleted."),
    "MAIN_IMPORT_DATABASE_IGNORE" : MessageLookupByLibrary.simpleMessage("Ignore"),
    "MAIN_IMPORT_DATABASE_IMPORT" : MessageLookupByLibrary.simpleMessage("Import"),
    "MODEL_CHANGE_CREATED" : MessageLookupByLibrary.simpleMessage("Created"),
    "MODEL_CHANGE_FIELD_DISABLED" : m17,
    "MODEL_CHANGE_FIELD_ENABLED" : m18,
    "MODEL_CHANGE_FIELD_MODIFIED" : m19,
    "NO_PRODUCTS" : MessageLookupByLibrary.simpleMessage("No products"),
    "PERMISSIONS_STORAGE_PERMANENTLY_BODY" : MessageLookupByLibrary.simpleMessage("Unfortunately you have permanently taken away my access to the memory, but I need it for the database. But I can redirect you to the settings where I can regain access."),
    "PERMISSIONS_STORAGE_PERMANENTLY_NOPE" : MessageLookupByLibrary.simpleMessage("No!"),
    "PERMISSIONS_STORAGE_PERMANENTLY_OKAY" : MessageLookupByLibrary.simpleMessage("Okay"),
    "PERMISSIONS_STORAGE_PERMANENTLY_TITLE" : MessageLookupByLibrary.simpleMessage("Access to storage"),
    "PERMISSIONS_STORAGE_RATIONALE_BODY" : MessageLookupByLibrary.simpleMessage("I need access to the memory for the database, without it Blackout can unfortunately not work"),
    "PERMISSIONS_STORAGE_RATIONALE_OKAY" : MessageLookupByLibrary.simpleMessage("Okay!"),
    "PERMISSIONS_STORAGE_RATIONALE_TITLE" : MessageLookupByLibrary.simpleMessage("Access to storage"),
    "PRODUCTS" : MessageLookupByLibrary.simpleMessage("Products"),
    "PRODUCT_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Description"),
    "PRODUCT_EAN" : MessageLookupByLibrary.simpleMessage("Product code"),
    "SETTINGS_TITLE" : MessageLookupByLibrary.simpleMessage("Settings"),
    "SETTINGS_USERNAME" : MessageLookupByLibrary.simpleMessage("Username"),
    "SETUP_CREATE_HOME" : MessageLookupByLibrary.simpleMessage("Create"),
    "SETUP_CREATE_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("What would you like to call your household? Choose wisely, you cannot change it."),
    "SETUP_FINISH" : MessageLookupByLibrary.simpleMessage("Finish"),
    "SETUP_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Do you want to join an existing household or start a new one?"),
    "SETUP_HOME_NAME" : MessageLookupByLibrary.simpleMessage("Name of your household"),
    "SETUP_JOIN_HOME" : MessageLookupByLibrary.simpleMessage("Join"),
    "SETUP_JOIN_HOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Simply scan the QR Code on another device to join the household."),
    "SETUP_USERNAME" : MessageLookupByLibrary.simpleMessage("Username"),
    "SETUP_USERNAME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("To track your actions, I need a username from you. If you do not like it later, you can change it."),
    "SETUP_WELCOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Welcome to Blackout.\nWe\'ll just set up the app, then you\'ll be good to go."),
    "SPEEDDIAL_ADD_TO_CHARGE" : MessageLookupByLibrary.simpleMessage("Add"),
    "SPEEDDIAL_CREATE_CHARGE" : MessageLookupByLibrary.simpleMessage("Create charge"),
    "SPEEDDIAL_CREATE_GROUP" : MessageLookupByLibrary.simpleMessage("Create group"),
    "SPEEDDIAL_CREATE_PRODUCT" : MessageLookupByLibrary.simpleMessage("Create product"),
    "SPEEDDIAL_GOTO_HOME" : MessageLookupByLibrary.simpleMessage("Home"),
    "SPEEDDIAL_SCAN" : MessageLookupByLibrary.simpleMessage("Scan barcode"),
    "SPEEDDIAL_TAKE_FROM_CHARGE" : MessageLookupByLibrary.simpleMessage("Take"),
    "UNITS" : MessageLookupByLibrary.simpleMessage("Charges"),
    "UNIT_CREATED_AT" : m20,
    "UNIT_EXPIRATION_DATE" : MessageLookupByLibrary.simpleMessage("Best before"),
    "UNIT_NOTIFICATION_DATE" : MessageLookupByLibrary.simpleMessage("Notify at"),
    "WARN_AMOUNT_COULD_NOT_BE_PARSED" : m21,
    "WARN_DESCRIPTION_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Description must not be empty"),
    "WARN_EAN_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Product code must not be empty"),
    "WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED" : m22,
    "WARN_NAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Name must not be empty"),
    "WARN_NOTIFICATION_DATE_COULD_NOT_BE_PARSED" : m23,
    "WARN_USERNAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Username must not be empty")
  };
}
