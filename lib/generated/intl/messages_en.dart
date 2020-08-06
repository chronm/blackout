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

  static m0(creationDate) => "created ${creationDate}";

  static m1(date) => "good until ${date}";

  static m2(amount, date) => "added ${amount} ${date}";

  static m3(amount, date) => "Took ${amount} ${date}";

  static m4(amount) => "Available: ${amount}";

  static m5(days) => "${Intl.plural(days, zero: '', one: '1 day', other: '${days} days')}";

  static m6(months) => "${Intl.plural(months, zero: '', one: 'in 1 month', other: 'in ${months} months')}";

  static m7(weeks) => "${Intl.plural(weeks, zero: '', one: 'in 1 week', other: 'in ${weeks} weeks')}";

  static m8(expirationDate) => "expired ${expirationDate}";

  static m9(expirationDate) => "Expires at ${expirationDate}";

  static m10(interval) => "expires ${interval}";

  static m11(hours) => "${Intl.plural(hours, zero: '', one: '1 hour', other: '${hours} hours')}";

  static m12(amount) => "Less than ${amount} available";

  static m13(minutes) => "${Intl.plural(minutes, zero: '', one: '1 minute', other: '${minutes} minutes')}";

  static m14(months) => "${Intl.plural(months, zero: '', one: '1 month', other: '${months} months')}";

  static m15(notificationDate) => "Notify at ${notificationDate}";

  static m16(seconds) => "${Intl.plural(seconds, zero: '', one: '1 second', other: '${seconds} seconds')}";

  static m17(weeks) => "${Intl.plural(weeks, zero: '', one: '1 week', other: '${weeks} weeks')}";

  static m18(years) => "${Intl.plural(years, zero: '', one: '1 year', other: '${years} years')}";

  static m19(field, from) => "Disabled ${field} (${from})";

  static m20(field, to) => "Enabled ${field} (${to})";

  static m21(field, from, to) => "Changed ${field} from ${from} to ${to}";

  static m22(amount) => "${amount} is not valid";

  static m23(expirationDate) => "${expirationDate} is not a valid date";

  static m24(notificationDate) => "${notificationDate} is not valid";

  static m25(period) => "${period} is not a valid time span";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "BATCHES" : MessageLookupByLibrary.simpleMessage("Batches"),
    "BATCH_CREATED_AT" : m0,
    "BATCH_EXPIRATION_DATE" : MessageLookupByLibrary.simpleMessage("Best before"),
    "BATCH_GOOD_UNTIL" : m1,
    "BATCH_NOTIFICATION_DATE" : MessageLookupByLibrary.simpleMessage("Notify at"),
    "CHANGELOG" : MessageLookupByLibrary.simpleMessage("Changelog"),
    "CHANGELOG_OKAY" : MessageLookupByLibrary.simpleMessage("Okay"),
    "CHANGES" : MessageLookupByLibrary.simpleMessage("Changes"),
    "CHANGE_ADDED" : m2,
    "CHANGE_TOOK" : m3,
    "DIALOG_ACCEPT_BUTTON" : MessageLookupByLibrary.simpleMessage("Accept"),
    "DIALOG_ADD_TO_BATCH" : MessageLookupByLibrary.simpleMessage("Add tobatch"),
    "DIALOG_CANCEL_BUTTON" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "DIALOG_TAKE_FROM_BATCH" : MessageLookupByLibrary.simpleMessage("Take frombatch"),
    "GENERAL_AMOUNT_AVAILABLE" : m4,
    "GENERAL_DAYS" : m5,
    "GENERAL_DELETE" : MessageLookupByLibrary.simpleMessage("Delete"),
    "GENERAL_DELETE_CONFIRMATION" : MessageLookupByLibrary.simpleMessage("Really delete?"),
    "GENERAL_DELETE_CONFIRMATION_NO" : MessageLookupByLibrary.simpleMessage("No"),
    "GENERAL_DELETE_CONFIRMATION_YES" : MessageLookupByLibrary.simpleMessage("Yes"),
    "GENERAL_EVENT_IN_MONTHS" : m6,
    "GENERAL_EVENT_IN_OVER_A_YEAR" : MessageLookupByLibrary.simpleMessage("in over one year"),
    "GENERAL_EVENT_IN_WEEKS" : m7,
    "GENERAL_EVENT_OVER_A_YEAR_AGO" : MessageLookupByLibrary.simpleMessage("over one year ago"),
    "GENERAL_EVENT_TODAY" : MessageLookupByLibrary.simpleMessage("today"),
    "GENERAL_EVENT_TOMORROW" : MessageLookupByLibrary.simpleMessage("tomorrow"),
    "GENERAL_EVENT_YESTERDAY" : MessageLookupByLibrary.simpleMessage("yesterday"),
    "GENERAL_EXPIRED_AGO" : m8,
    "GENERAL_EXPIRES_AT" : m9,
    "GENERAL_EXPIRES_IN" : m10,
    "GENERAL_HOURS" : m11,
    "GENERAL_LESS_THAN_AVAILABLE" : m12,
    "GENERAL_MINUTES" : m13,
    "GENERAL_MONTHS" : m14,
    "GENERAL_NOTHING_HERE" : MessageLookupByLibrary.simpleMessage("Nothing here"),
    "GENERAL_NOTIFY_AT" : m15,
    "GENERAL_SAVE" : MessageLookupByLibrary.simpleMessage("Save"),
    "GENERAL_SEARCH" : MessageLookupByLibrary.simpleMessage("Search ..."),
    "GENERAL_SECONDS" : m16,
    "GENERAL_UNIT" : MessageLookupByLibrary.simpleMessage("Unit"),
    "GENERAL_WARN_INTERVAL" : MessageLookupByLibrary.simpleMessage("Warn period"),
    "GENERAL_WARN_INTERVAL_HELP" : MessageLookupByLibrary.simpleMessage("If abatch has an expiration date, Blackout will notify you of this period in advance.\nExample: \"P1Y2M3W4D\" corresponds to 1 year, 2 months, 3 weeks and 4 days"),
    "GENERAL_WEEKS" : m17,
    "GENERAL_YEARS" : m18,
    "GROUP_MINIMUM_AMOUNT" : MessageLookupByLibrary.simpleMessage("Minimum amount"),
    "GROUP_NAME" : MessageLookupByLibrary.simpleMessage("Name of this group"),
    "GROUP_PLURAL_NAME" : MessageLookupByLibrary.simpleMessage("Plural form of name"),
    "GROUP_PLURAL_NAME_INFO" : MessageLookupByLibrary.simpleMessage("Will be used when amount is zero or greater than one."),
    "HOME_ASK_FOR_UPDATES_BODY" : MessageLookupByLibrary.simpleMessage("There is an update available, do you want to install it?"),
    "HOME_ASK_FOR_UPDATES_DENY" : MessageLookupByLibrary.simpleMessage("No"),
    "HOME_ASK_FOR_UPDATES_OKAY" : MessageLookupByLibrary.simpleMessage("Yes"),
    "HOME_ASK_FOR_UPDATES_TITLE" : MessageLookupByLibrary.simpleMessage("Update available"),
    "HOME_PRODUCTS_AND_GROUPS" : MessageLookupByLibrary.simpleMessage("Products and Groups"),
    "HOME_UPDATE_AVAILABLE_BODY" : MessageLookupByLibrary.simpleMessage("You can download a new version from the store."),
    "HOME_UPDATE_AVAILABLE_DENY" : MessageLookupByLibrary.simpleMessage("No"),
    "HOME_UPDATE_AVAILABLE_OKAY" : MessageLookupByLibrary.simpleMessage("Yes"),
    "HOME_UPDATE_AVAILABLE_TITLE" : MessageLookupByLibrary.simpleMessage("Update available"),
    "MAIN_IMPORT_DATABASE" : MessageLookupByLibrary.simpleMessage("I found a backup. Should I import it or do you want to ignore it? If you ignore it, it will be deleted."),
    "MAIN_IMPORT_DATABASE_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("If you want me to import it, please enter the password for the database.\nYou can also ignore the backup, but then it will be permanently deleted."),
    "MAIN_IMPORT_DATABASE_ERROR" : MessageLookupByLibrary.simpleMessage("Your password was wrong."),
    "MAIN_IMPORT_DATABASE_IGNORE" : MessageLookupByLibrary.simpleMessage("Ignore"),
    "MAIN_IMPORT_DATABASE_IMPORT" : MessageLookupByLibrary.simpleMessage("Import"),
    "MAIN_IMPORT_DATABASE_TITLE" : MessageLookupByLibrary.simpleMessage("I found a backup."),
    "MODEL_CHANGE_CREATED" : MessageLookupByLibrary.simpleMessage("Created"),
    "MODEL_CHANGE_FIELD_DISABLED" : m19,
    "MODEL_CHANGE_FIELD_ENABLED" : m20,
    "MODEL_CHANGE_FIELD_MODIFIED" : m21,
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
    "SETUP_STEP_CREATE_HOME_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("What would you like to call your household? Choose wisely, you cannot change it."),
    "SETUP_STEP_CREATE_HOME_ERROR" : MessageLookupByLibrary.simpleMessage("Please enter a name."),
    "SETUP_STEP_CREATE_HOME_TITLE" : MessageLookupByLibrary.simpleMessage("Household"),
    "SETUP_STEP_CREATE_PASSWORD_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Please enter a password that will be used to encrypt your local database."),
    "SETUP_STEP_CREATE_PASSWORD_ERROR" : MessageLookupByLibrary.simpleMessage("Password must not be empty."),
    "SETUP_STEP_CREATE_PASSWORD_HELP" : MessageLookupByLibrary.simpleMessage("Password is insecure."),
    "SETUP_STEP_CREATE_PASSWORD_HINT_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Your password should have at least 16 characters and contain the following characters:\n - upper and lower case letters\n - numbers\n - special characters"),
    "SETUP_STEP_CREATE_PASSWORD_HINT_TITLE" : MessageLookupByLibrary.simpleMessage("Password guidelines"),
    "SETUP_STEP_CREATE_PASSWORD_TITLE" : MessageLookupByLibrary.simpleMessage("Password"),
    "SETUP_STEP_CREATE_USERNAME_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("To track your actions, I need a username from you. If you do not like it later, you can change it."),
    "SETUP_STEP_CREATE_USERNAME_ERROR" : MessageLookupByLibrary.simpleMessage("Please enter a user name."),
    "SETUP_STEP_CREATE_USERNAME_TITLE" : MessageLookupByLibrary.simpleMessage("Username"),
    "SETUP_STEP_FINISH_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("If you are satisfied, you can complete the setup now."),
    "SETUP_STEP_FINISH_DESCRIPTION_ERROR" : MessageLookupByLibrary.simpleMessage("Please look again at the previous steps."),
    "SETUP_STEP_FINISH_SEND" : MessageLookupByLibrary.simpleMessage("Send"),
    "SETUP_STEP_FINISH_TITLE" : MessageLookupByLibrary.simpleMessage("Finish"),
    "SETUP_STEP_INTRODUCTION_DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Welcome to Blackout.\nWe\'ll just set up the app, then you\'ll be good to go."),
    "SETUP_STEP_INTRODUCTION_TITLE" : MessageLookupByLibrary.simpleMessage("Introduction"),
    "SETUP_USERNAME" : MessageLookupByLibrary.simpleMessage("Username"),
    "SETUP_USERNAME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("To track your actions, I need a username from you. If you do not like it later, you can change it."),
    "SETUP_WELCOME_CARD_TITLE" : MessageLookupByLibrary.simpleMessage("Welcome to Blackout.\nWe\'ll just set up the app, then you\'ll be good to go."),
    "SPEEDDIAL_ADD_TO_BATCH" : MessageLookupByLibrary.simpleMessage("Add"),
    "SPEEDDIAL_CREATE_BATCH" : MessageLookupByLibrary.simpleMessage("Create batch"),
    "SPEEDDIAL_CREATE_GROUP" : MessageLookupByLibrary.simpleMessage("Create group"),
    "SPEEDDIAL_CREATE_PRODUCT" : MessageLookupByLibrary.simpleMessage("Create product"),
    "SPEEDDIAL_GOTO_HOME" : MessageLookupByLibrary.simpleMessage("Home"),
    "SPEEDDIAL_SCAN" : MessageLookupByLibrary.simpleMessage("Scan barcode"),
    "SPEEDDIAL_TAKE_FROM_BATCH" : MessageLookupByLibrary.simpleMessage("Take"),
    "UNITENUM_VOLUME" : MessageLookupByLibrary.simpleMessage("Volume"),
    "UNITENUM_WEIGHT" : MessageLookupByLibrary.simpleMessage("Weight"),
    "WARN_AMOUNT_COULD_NOT_BE_PARSED" : m22,
    "WARN_BATCH_TOO_MUCH" : MessageLookupByLibrary.simpleMessage("This is too much"),
    "WARN_DESCRIPTION_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Description must not be empty"),
    "WARN_EAN_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Product code must not be empty"),
    "WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED" : m23,
    "WARN_NAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Name must not be empty"),
    "WARN_NOTIFICATION_DATE_COULD_NOT_BE_PARSED" : m24,
    "WARN_PERIOD_COULD_NOT_BE_PARSED" : m25,
    "WARN_PERIOD_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Period must not be empty"),
    "WARN_PLURAL_NAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Plural form must not be empty"),
    "WARN_REFILL_LIMIT_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Refill limit must not be empty"),
    "WARN_SETUP_STEP_CREATE_HOME_ERROR" : MessageLookupByLibrary.simpleMessage(""),
    "WARN_SETUP_STEP_CREATE_USERNAME_ERROR" : MessageLookupByLibrary.simpleMessage(""),
    "WARN_USERNAME_MUST_NOT_BE_EMPTY" : MessageLookupByLibrary.simpleMessage("Username must not be empty")
  };
}
