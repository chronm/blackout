// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `added {amount} {date}`
  String CHANGE_ADDED(Object amount, Object date) {
    return Intl.message(
      'added $amount $date',
      name: 'CHANGE_ADDED',
      desc: '',
      args: [amount, date],
    );
  }

  /// `Changelog`
  String get CHANGELOG {
    return Intl.message(
      'Changelog',
      name: 'CHANGELOG',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get CHANGELOG_OKAY {
    return Intl.message(
      'Okay',
      name: 'CHANGELOG_OKAY',
      desc: '',
      args: [],
    );
  }

  /// `Changes`
  String get CHANGES {
    return Intl.message(
      'Changes',
      name: 'CHANGES',
      desc: '',
      args: [],
    );
  }

  /// `Took {amount} {date}`
  String CHANGE_TOOK(Object amount, Object date) {
    return Intl.message(
      'Took $amount $date',
      name: 'CHANGE_TOOK',
      desc: '',
      args: [amount, date],
    );
  }

  /// `Accept`
  String get DIALOG_ACCEPT_BUTTON {
    return Intl.message(
      'Accept',
      name: 'DIALOG_ACCEPT_BUTTON',
      desc: '',
      args: [],
    );
  }

  /// `Add to charge`
  String get DIALOG_ADD_TO_CHARGE {
    return Intl.message(
      'Add to charge',
      name: 'DIALOG_ADD_TO_CHARGE',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get DIALOG_CANCEL_BUTTON {
    return Intl.message(
      'Cancel',
      name: 'DIALOG_CANCEL_BUTTON',
      desc: '',
      args: [],
    );
  }

  /// `Take from charge`
  String get DIALOG_TAKE_FROM_CHARGE {
    return Intl.message(
      'Take from charge',
      name: 'DIALOG_TAKE_FROM_CHARGE',
      desc: '',
      args: [],
    );
  }

  /// `Available: {amount}`
  String GENERAL_AMOUNT_AVAILABLE(Object amount) {
    return Intl.message(
      'Available: $amount',
      name: 'GENERAL_AMOUNT_AVAILABLE',
      desc: '',
      args: [amount],
    );
  }

  /// `{days, plural, zero{} one{1 day} other{{days} days}}`
  String GENERAL_DAYS(num days) {
    return Intl.plural(
      days,
      zero: '',
      one: '1 day',
      other: '$days days',
      name: 'GENERAL_DAYS',
      desc: '',
      args: [days],
    );
  }

  /// `Delete`
  String get GENERAL_DELETE {
    return Intl.message(
      'Delete',
      name: 'GENERAL_DELETE',
      desc: '',
      args: [],
    );
  }

  /// `Really delete?`
  String get GENERAL_DELETE_CONFIRMATION {
    return Intl.message(
      'Really delete?',
      name: 'GENERAL_DELETE_CONFIRMATION',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get GENERAL_DELETE_CONFIRMATION_NO {
    return Intl.message(
      'No',
      name: 'GENERAL_DELETE_CONFIRMATION_NO',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get GENERAL_DELETE_CONFIRMATION_YES {
    return Intl.message(
      'Yes',
      name: 'GENERAL_DELETE_CONFIRMATION_YES',
      desc: '',
      args: [],
    );
  }

  /// `{months, plural, zero{} one{in 1 month} other{in {months} months}}`
  String GENERAL_EVENT_IN_MONTHS(num months) {
    return Intl.plural(
      months,
      zero: '',
      one: 'in 1 month',
      other: 'in $months months',
      name: 'GENERAL_EVENT_IN_MONTHS',
      desc: '',
      args: [months],
    );
  }

  /// `in over one year`
  String get GENERAL_EVENT_IN_OVER_A_YEAR {
    return Intl.message(
      'in over one year',
      name: 'GENERAL_EVENT_IN_OVER_A_YEAR',
      desc: '',
      args: [],
    );
  }

  /// `{weeks, plural, zero{} one{in 1 week} other{in {weeks} weeks}}`
  String GENERAL_EVENT_IN_WEEKS(num weeks) {
    return Intl.plural(
      weeks,
      zero: '',
      one: 'in 1 week',
      other: 'in $weeks weeks',
      name: 'GENERAL_EVENT_IN_WEEKS',
      desc: '',
      args: [weeks],
    );
  }

  /// `over one year ago`
  String get GENERAL_EVENT_OVER_A_YEAR_AGO {
    return Intl.message(
      'over one year ago',
      name: 'GENERAL_EVENT_OVER_A_YEAR_AGO',
      desc: '',
      args: [],
    );
  }

  /// `today`
  String get GENERAL_EVENT_TODAY {
    return Intl.message(
      'today',
      name: 'GENERAL_EVENT_TODAY',
      desc: '',
      args: [],
    );
  }

  /// `tomorrow`
  String get GENERAL_EVENT_TOMORROW {
    return Intl.message(
      'tomorrow',
      name: 'GENERAL_EVENT_TOMORROW',
      desc: '',
      args: [],
    );
  }

  /// `yesterday`
  String get GENERAL_EVENT_YESTERDAY {
    return Intl.message(
      'yesterday',
      name: 'GENERAL_EVENT_YESTERDAY',
      desc: '',
      args: [],
    );
  }

  /// `expired {expirationDate}`
  String GENERAL_EXPIRED_AGO(Object expirationDate) {
    return Intl.message(
      'expired $expirationDate',
      name: 'GENERAL_EXPIRED_AGO',
      desc: '',
      args: [expirationDate],
    );
  }

  /// `Expires at {expirationDate}`
  String GENERAL_EXPIRES_AT(Object expirationDate) {
    return Intl.message(
      'Expires at $expirationDate',
      name: 'GENERAL_EXPIRES_AT',
      desc: '',
      args: [expirationDate],
    );
  }

  /// `expires {interval}`
  String GENERAL_EXPIRES_IN(Object interval) {
    return Intl.message(
      'expires $interval',
      name: 'GENERAL_EXPIRES_IN',
      desc: '',
      args: [interval],
    );
  }

  /// `{hours, plural, zero{} one{1 hour} other{{hours} hours}}`
  String GENERAL_HOURS(num hours) {
    return Intl.plural(
      hours,
      zero: '',
      one: '1 hour',
      other: '$hours hours',
      name: 'GENERAL_HOURS',
      desc: '',
      args: [hours],
    );
  }

  /// `Less than {amount} available`
  String GENERAL_LESS_THAN_AVAILABLE(Object amount) {
    return Intl.message(
      'Less than $amount available',
      name: 'GENERAL_LESS_THAN_AVAILABLE',
      desc: '',
      args: [amount],
    );
  }

  /// `{minutes, plural, zero{} one{1 minute} other{{minutes} minutes}}`
  String GENERAL_MINUTES(num minutes) {
    return Intl.plural(
      minutes,
      zero: '',
      one: '1 minute',
      other: '$minutes minutes',
      name: 'GENERAL_MINUTES',
      desc: '',
      args: [minutes],
    );
  }

  /// `{months, plural, zero{} one{1 month} other{{months} months}}`
  String GENERAL_MONTHS(num months) {
    return Intl.plural(
      months,
      zero: '',
      one: '1 month',
      other: '$months months',
      name: 'GENERAL_MONTHS',
      desc: '',
      args: [months],
    );
  }

  /// `Nothing here`
  String get GENERAL_NOTHING_HERE {
    return Intl.message(
      'Nothing here',
      name: 'GENERAL_NOTHING_HERE',
      desc: '',
      args: [],
    );
  }

  /// `Notify at {notificationDate}`
  String GENERAL_NOTIFY_AT(Object notificationDate) {
    return Intl.message(
      'Notify at $notificationDate',
      name: 'GENERAL_NOTIFY_AT',
      desc: '',
      args: [notificationDate],
    );
  }

  /// `Save`
  String get GENERAL_SAVE {
    return Intl.message(
      'Save',
      name: 'GENERAL_SAVE',
      desc: '',
      args: [],
    );
  }

  /// `Search ...`
  String get GENERAL_SEARCH {
    return Intl.message(
      'Search ...',
      name: 'GENERAL_SEARCH',
      desc: '',
      args: [],
    );
  }

  /// `{seconds, plural, zero{} one{1 second} other{{seconds} seconds}}`
  String GENERAL_SECONDS(num seconds) {
    return Intl.plural(
      seconds,
      zero: '',
      one: '1 second',
      other: '$seconds seconds',
      name: 'GENERAL_SECONDS',
      desc: '',
      args: [seconds],
    );
  }

  /// `{weeks, plural, zero{} one{1 week} other{{weeks} weeks}}`
  String GENERAL_WEEKS(num weeks) {
    return Intl.plural(
      weeks,
      zero: '',
      one: '1 week',
      other: '$weeks weeks',
      name: 'GENERAL_WEEKS',
      desc: '',
      args: [weeks],
    );
  }

  /// `{years, plural, zero{} one{1 year} other{{years} years}}`
  String GENERAL_YEARS(num years) {
    return Intl.plural(
      years,
      zero: '',
      one: '1 year',
      other: '$years years',
      name: 'GENERAL_YEARS',
      desc: '',
      args: [years],
    );
  }

  /// `Warn me before expiration`
  String get GROUP_BEST_BEFORE {
    return Intl.message(
      'Warn me before expiration',
      name: 'GROUP_BEST_BEFORE',
      desc: '',
      args: [],
    );
  }

  /// `Minimum amount`
  String get GROUP_MINIMUM_AMOUNT {
    return Intl.message(
      'Minimum amount',
      name: 'GROUP_MINIMUM_AMOUNT',
      desc: '',
      args: [],
    );
  }

  /// `Name of this group`
  String get GROUP_NAME {
    return Intl.message(
      'Name of this group',
      name: 'GROUP_NAME',
      desc: '',
      args: [],
    );
  }

  /// `Plural form of name`
  String get GROUP_PLURAL_NAME {
    return Intl.message(
      'Plural form of name',
      name: 'GROUP_PLURAL_NAME',
      desc: '',
      args: [],
    );
  }

  /// `Products and Groups`
  String get HOME_PRODUCTS_AND_GROUPS {
    return Intl.message(
      'Products and Groups',
      name: 'HOME_PRODUCTS_AND_GROUPS',
      desc: '',
      args: [],
    );
  }

  /// `I found a backup. Should I import it or do you want to ignore it? If you ignore it, it will be deleted.`
  String get MAIN_IMPORT_DATABASE {
    return Intl.message(
      'I found a backup. Should I import it or do you want to ignore it? If you ignore it, it will be deleted.',
      name: 'MAIN_IMPORT_DATABASE',
      desc: '',
      args: [],
    );
  }

  /// `Ignore`
  String get MAIN_IMPORT_DATABASE_IGNORE {
    return Intl.message(
      'Ignore',
      name: 'MAIN_IMPORT_DATABASE_IGNORE',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get MAIN_IMPORT_DATABASE_IMPORT {
    return Intl.message(
      'Import',
      name: 'MAIN_IMPORT_DATABASE_IMPORT',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get MODEL_CHANGE_CREATED {
    return Intl.message(
      'Created',
      name: 'MODEL_CHANGE_CREATED',
      desc: '',
      args: [],
    );
  }

  /// `Disabled {field} ({from})`
  String MODEL_CHANGE_FIELD_DISABLED(Object field, Object from) {
    return Intl.message(
      'Disabled $field ($from)',
      name: 'MODEL_CHANGE_FIELD_DISABLED',
      desc: '',
      args: [field, from],
    );
  }

  /// `Enabled {field} ({to})`
  String MODEL_CHANGE_FIELD_ENABLED(Object field, Object to) {
    return Intl.message(
      'Enabled $field ($to)',
      name: 'MODEL_CHANGE_FIELD_ENABLED',
      desc: '',
      args: [field, to],
    );
  }

  /// `Changed {field} from {from} to {to}`
  String MODEL_CHANGE_FIELD_MODIFIED(Object field, Object from, Object to) {
    return Intl.message(
      'Changed $field from $from to $to',
      name: 'MODEL_CHANGE_FIELD_MODIFIED',
      desc: '',
      args: [field, from, to],
    );
  }

  /// `No products`
  String get NO_PRODUCTS {
    return Intl.message(
      'No products',
      name: 'NO_PRODUCTS',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately you have permanently taken away my access to the memory, but I need it for the database. But I can redirect you to the settings where I can regain access.`
  String get PERMISSIONS_STORAGE_PERMANENTLY_BODY {
    return Intl.message(
      'Unfortunately you have permanently taken away my access to the memory, but I need it for the database. But I can redirect you to the settings where I can regain access.',
      name: 'PERMISSIONS_STORAGE_PERMANENTLY_BODY',
      desc: '',
      args: [],
    );
  }

  /// `No!`
  String get PERMISSIONS_STORAGE_PERMANENTLY_NOPE {
    return Intl.message(
      'No!',
      name: 'PERMISSIONS_STORAGE_PERMANENTLY_NOPE',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get PERMISSIONS_STORAGE_PERMANENTLY_OKAY {
    return Intl.message(
      'Okay',
      name: 'PERMISSIONS_STORAGE_PERMANENTLY_OKAY',
      desc: '',
      args: [],
    );
  }

  /// `Access to storage`
  String get PERMISSIONS_STORAGE_PERMANENTLY_TITLE {
    return Intl.message(
      'Access to storage',
      name: 'PERMISSIONS_STORAGE_PERMANENTLY_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `I need access to the memory for the database, without it Blackout can unfortunately not work`
  String get PERMISSIONS_STORAGE_RATIONALE_BODY {
    return Intl.message(
      'I need access to the memory for the database, without it Blackout can unfortunately not work',
      name: 'PERMISSIONS_STORAGE_RATIONALE_BODY',
      desc: '',
      args: [],
    );
  }

  /// `Okay!`
  String get PERMISSIONS_STORAGE_RATIONALE_OKAY {
    return Intl.message(
      'Okay!',
      name: 'PERMISSIONS_STORAGE_RATIONALE_OKAY',
      desc: '',
      args: [],
    );
  }

  /// `Access to storage`
  String get PERMISSIONS_STORAGE_RATIONALE_TITLE {
    return Intl.message(
      'Access to storage',
      name: 'PERMISSIONS_STORAGE_RATIONALE_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get PRODUCT_DESCRIPTION {
    return Intl.message(
      'Description',
      name: 'PRODUCT_DESCRIPTION',
      desc: '',
      args: [],
    );
  }

  /// `Product code`
  String get PRODUCT_EAN {
    return Intl.message(
      'Product code',
      name: 'PRODUCT_EAN',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get PRODUCTS {
    return Intl.message(
      'Products',
      name: 'PRODUCTS',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get SETTINGS_TITLE {
    return Intl.message(
      'Settings',
      name: 'SETTINGS_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get SETTINGS_USERNAME {
    return Intl.message(
      'Username',
      name: 'SETTINGS_USERNAME',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get SETUP_CREATE_HOME {
    return Intl.message(
      'Create',
      name: 'SETUP_CREATE_HOME',
      desc: '',
      args: [],
    );
  }

  /// `What would you like to call your household? Choose wisely, you cannot change it.`
  String get SETUP_CREATE_HOME_CARD_TITLE {
    return Intl.message(
      'What would you like to call your household? Choose wisely, you cannot change it.',
      name: 'SETUP_CREATE_HOME_CARD_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get SETUP_FINISH {
    return Intl.message(
      'Finish',
      name: 'SETUP_FINISH',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to join an existing household or start a new one?`
  String get SETUP_HOME_CARD_TITLE {
    return Intl.message(
      'Do you want to join an existing household or start a new one?',
      name: 'SETUP_HOME_CARD_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Name of your household`
  String get SETUP_HOME_NAME {
    return Intl.message(
      'Name of your household',
      name: 'SETUP_HOME_NAME',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get SETUP_JOIN_HOME {
    return Intl.message(
      'Join',
      name: 'SETUP_JOIN_HOME',
      desc: '',
      args: [],
    );
  }

  /// `Simply scan the QR Code on another device to join the household.`
  String get SETUP_JOIN_HOME_CARD_TITLE {
    return Intl.message(
      'Simply scan the QR Code on another device to join the household.',
      name: 'SETUP_JOIN_HOME_CARD_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get SETUP_USERNAME {
    return Intl.message(
      'Username',
      name: 'SETUP_USERNAME',
      desc: '',
      args: [],
    );
  }

  /// `To track your actions, I need a username from you. If you do not like it later, you can change it.`
  String get SETUP_USERNAME_CARD_TITLE {
    return Intl.message(
      'To track your actions, I need a username from you. If you do not like it later, you can change it.',
      name: 'SETUP_USERNAME_CARD_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Blackout.\nWe'll just set up the app, then you'll be good to go.`
  String get SETUP_WELCOME_CARD_TITLE {
    return Intl.message(
      'Welcome to Blackout.\nWe\'ll just set up the app, then you\'ll be good to go.',
      name: 'SETUP_WELCOME_CARD_TITLE',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get SPEEDDIAL_ADD_TO_CHARGE {
    return Intl.message(
      'Add',
      name: 'SPEEDDIAL_ADD_TO_CHARGE',
      desc: '',
      args: [],
    );
  }

  /// `Create charge`
  String get SPEEDDIAL_CREATE_CHARGE {
    return Intl.message(
      'Create charge',
      name: 'SPEEDDIAL_CREATE_CHARGE',
      desc: '',
      args: [],
    );
  }

  /// `Create group`
  String get SPEEDDIAL_CREATE_GROUP {
    return Intl.message(
      'Create group',
      name: 'SPEEDDIAL_CREATE_GROUP',
      desc: '',
      args: [],
    );
  }

  /// `Create product`
  String get SPEEDDIAL_CREATE_PRODUCT {
    return Intl.message(
      'Create product',
      name: 'SPEEDDIAL_CREATE_PRODUCT',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get SPEEDDIAL_GOTO_HOME {
    return Intl.message(
      'Home',
      name: 'SPEEDDIAL_GOTO_HOME',
      desc: '',
      args: [],
    );
  }

  /// `Scan barcode`
  String get SPEEDDIAL_SCAN {
    return Intl.message(
      'Scan barcode',
      name: 'SPEEDDIAL_SCAN',
      desc: '',
      args: [],
    );
  }

  /// `Take`
  String get SPEEDDIAL_TAKE_FROM_CHARGE {
    return Intl.message(
      'Take',
      name: 'SPEEDDIAL_TAKE_FROM_CHARGE',
      desc: '',
      args: [],
    );
  }

  /// `created {creationDate}`
  String UNIT_CREATED_AT(Object creationDate) {
    return Intl.message(
      'created $creationDate',
      name: 'UNIT_CREATED_AT',
      desc: '',
      args: [creationDate],
    );
  }

  /// `Best before`
  String get UNIT_EXPIRATION_DATE {
    return Intl.message(
      'Best before',
      name: 'UNIT_EXPIRATION_DATE',
      desc: '',
      args: [],
    );
  }

  /// `Notify at`
  String get UNIT_NOTIFICATION_DATE {
    return Intl.message(
      'Notify at',
      name: 'UNIT_NOTIFICATION_DATE',
      desc: '',
      args: [],
    );
  }

  /// `Charges`
  String get UNITS {
    return Intl.message(
      'Charges',
      name: 'UNITS',
      desc: '',
      args: [],
    );
  }

  /// `{amount} is not valid`
  String WARN_AMOUNT_COULD_NOT_BE_PARSED(Object amount) {
    return Intl.message(
      '$amount is not valid',
      name: 'WARN_AMOUNT_COULD_NOT_BE_PARSED',
      desc: '',
      args: [amount],
    );
  }

  /// `Description must not be empty`
  String get WARN_DESCRIPTION_MUST_NOT_BE_EMPTY {
    return Intl.message(
      'Description must not be empty',
      name: 'WARN_DESCRIPTION_MUST_NOT_BE_EMPTY',
      desc: '',
      args: [],
    );
  }

  /// `Product code must not be empty`
  String get WARN_EAN_MUST_NOT_BE_EMPTY {
    return Intl.message(
      'Product code must not be empty',
      name: 'WARN_EAN_MUST_NOT_BE_EMPTY',
      desc: '',
      args: [],
    );
  }

  /// `{expirationDate} is not valid`
  String WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED(Object expirationDate) {
    return Intl.message(
      '$expirationDate is not valid',
      name: 'WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED',
      desc: '',
      args: [expirationDate],
    );
  }

  /// `Name must not be empty`
  String get WARN_NAME_MUST_NOT_BE_EMPTY {
    return Intl.message(
      'Name must not be empty',
      name: 'WARN_NAME_MUST_NOT_BE_EMPTY',
      desc: '',
      args: [],
    );
  }

  /// `{notificationDate} is not valid`
  String WARN_NOTIFICATION_DATE_COULD_NOT_BE_PARSED(Object notificationDate) {
    return Intl.message(
      '$notificationDate is not valid',
      name: 'WARN_NOTIFICATION_DATE_COULD_NOT_BE_PARSED',
      desc: '',
      args: [notificationDate],
    );
  }

  /// `Username must not be empty`
  String get WARN_USERNAME_MUST_NOT_BE_EMPTY {
    return Intl.message(
      'Username must not be empty',
      name: 'WARN_USERNAME_MUST_NOT_BE_EMPTY',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}