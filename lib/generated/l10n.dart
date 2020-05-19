// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get _locale {
    return Intl.message(
      'en',
      name: '_locale',
      desc: '',
      args: [],
    );
  }

  String get setup {
    return Intl.message(
      'Setup',
      name: 'setup',
      desc: '',
      args: [],
    );
  }

  String get welcomeMessage {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  String get setYourUsername {
    return Intl.message(
      'How do you want do be called. This will be the same for each household you are part of and is used to identify you e.g. when you add or remove charges. You can change this later.',
      name: 'setYourUsername',
      desc: '',
      args: [],
    );
  }

  String get setYourHome {
    return Intl.message(
      'Do you want to join an existing household or create a new one?',
      name: 'setYourHome',
      desc: '',
      args: [],
    );
  }

  String get joinHome {
    return Intl.message(
      'Simply scan the QR Code on another device to join the household.',
      name: 'joinHome',
      desc: '',
      args: [],
    );
  }

  String get createHome {
    return Intl.message(
      'How do you want to call your household? You can change it later',
      name: 'createHome',
      desc: '',
      args: [],
    );
  }

  String get nameOfYourHousehold {
    return Intl.message(
      'Name of your household',
      name: 'nameOfYourHousehold',
      desc: '',
      args: [],
    );
  }

  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  String available(Object amount) {
    return Intl.message(
      'Available: $amount',
      name: 'available',
      desc: '',
      args: [amount],
    );
  }

  String get singular {
    return Intl.message(
      'What is the name of this group?',
      name: 'singular',
      desc: '',
      args: [],
    );
  }

  String get plural {
    return Intl.message(
      'If it has a plural form, enter here',
      name: 'plural',
      desc: '',
      args: [],
    );
  }

  String get modifyGroup {
    return Intl.message(
      'Modify Group',
      name: 'modifyGroup',
      desc: '',
      args: [],
    );
  }

  String get modifyProduct {
    return Intl.message(
      'Modify Product',
      name: 'modifyProduct',
      desc: '',
      args: [],
    );
  }

  String get modifyCharge {
    return Intl.message(
      'Modify Charge',
      name: 'modifyCharge',
      desc: '',
      args: [],
    );
  }

  String years(num years) {
    return Intl.plural(
      years,
      one: '1 year',
      other: '$years years',
      name: 'years',
      desc: '',
      args: [years],
    );
  }

  String months(num months) {
    return Intl.plural(
      months,
      one: '1 month',
      other: '$months months',
      name: 'months',
      desc: '',
      args: [months],
    );
  }

  String weeks(num weeks) {
    return Intl.plural(
      weeks,
      one: '1 week',
      other: '$weeks weeks',
      name: 'weeks',
      desc: '',
      args: [weeks],
    );
  }

  String days(num days) {
    return Intl.plural(
      days,
      one: '1 day',
      other: '$days days',
      name: 'days',
      desc: '',
      args: [days],
    );
  }

  String hours(num hours) {
    return Intl.plural(
      hours,
      one: '1 hour',
      other: '$hours hours',
      name: 'hours',
      desc: '',
      args: [hours],
    );
  }

  String minutes(num minutes) {
    return Intl.plural(
      minutes,
      one: '1 minute',
      other: '$minutes minutes',
      name: 'minutes',
      desc: '',
      args: [minutes],
    );
  }

  String seconds(num seconds) {
    return Intl.plural(
      seconds,
      one: '1 second',
      other: '$seconds seconds',
      name: 'seconds',
      desc: '',
      args: [seconds],
    );
  }

  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  String modifiedField(Object field, Object from, Object to) {
    return Intl.message(
      'Changed $field from $from to $to',
      name: 'modifiedField',
      desc: '',
      args: [field, from, to],
    );
  }

  String disabledField(Object field, Object from) {
    return Intl.message(
      'Disabled $field ($from)',
      name: 'disabledField',
      desc: '',
      args: [field, from],
    );
  }

  String enabledField(Object field, Object to) {
    return Intl.message(
      'Enabled $field ($to)',
      name: 'enabledField',
      desc: '',
      args: [field, to],
    );
  }

  String get changes {
    return Intl.message(
      'Changes',
      name: 'changes',
      desc: '',
      args: [],
    );
  }

  String get nameMustNotBeEmpty {
    return Intl.message(
      'Name must not be empty',
      name: 'nameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  String get warnMe {
    return Intl.message(
      'Warn me before expiration',
      name: 'warnMe',
      desc: '',
      args: [],
    );
  }

  String get minimumAmount {
    return Intl.message(
      'Minimum amount',
      name: 'minimumAmount',
      desc: '',
      args: [],
    );
  }

  String amountCouldNotBeParsed(Object amount) {
    return Intl.message(
      '$amount is not valid',
      name: 'amountCouldNotBeParsed',
      desc: '',
      args: [amount],
    );
  }

  String createdAt(Object create) {
    return Intl.message(
      'created $create',
      name: 'createdAt',
      desc: '',
      args: [create],
    );
  }

  String expired(Object time) {
    return Intl.message(
      'expired $time',
      name: 'expired',
      desc: '',
      args: [time],
    );
  }

  String expires(Object time) {
    return Intl.message(
      'expires $time',
      name: 'expires',
      desc: '',
      args: [time],
    );
  }

  String inWeeks(num weeks) {
    return Intl.plural(
      weeks,
      one: 'in $weeks week',
      other: 'in $weeks weeks',
      name: 'inWeeks',
      desc: '',
      args: [weeks],
    );
  }

  String inMonths(num months) {
    return Intl.plural(
      months,
      one: 'in $months month',
      other: 'in $months months',
      name: 'inMonths',
      desc: '',
      args: [months],
    );
  }

  String get longAgo {
    return Intl.message(
      'very long ago',
      name: 'longAgo',
      desc: '',
      args: [],
    );
  }

  String get today {
    return Intl.message(
      'today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  String get yesterday {
    return Intl.message(
      'yesterday',
      name: 'yesterday',
      desc: '',
      args: [],
    );
  }

  String get tomorrow {
    return Intl.message(
      'tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  String get future {
    return Intl.message(
      'far in the future',
      name: 'future',
      desc: '',
      args: [],
    );
  }

  String notify(Object time) {
    return Intl.message(
      'notify $time',
      name: 'notify',
      desc: '',
      args: [time],
    );
  }

  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  String get descriptionMustNotBeEmpty {
    return Intl.message(
      'Description must not be empty',
      name: 'descriptionMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  String get ean {
    return Intl.message(
      'Product code (ean)',
      name: 'ean',
      desc: '',
      args: [],
    );
  }

  String removed(Object amount, Object date) {
    return Intl.message(
      'Took $amount $date',
      name: 'removed',
      desc: '',
      args: [amount, date],
    );
  }

  String added(Object amount, Object date) {
    return Intl.message(
      'Added $amount $date',
      name: 'added',
      desc: '',
      args: [amount, date],
    );
  }

  String get expirationDate {
    return Intl.message(
      'Best before',
      name: 'expirationDate',
      desc: '',
      args: [],
    );
  }

  String get notificationDate {
    return Intl.message(
      'Notify at',
      name: 'notificationDate',
      desc: '',
      args: [],
    );
  }

  String expirationDateCouldNotBeParsed(Object expirationDate) {
    return Intl.message(
      '$expirationDate is not valid',
      name: 'expirationDateCouldNotBeParsed',
      desc: '',
      args: [expirationDate],
    );
  }

  String notificationDateCouldNotBeParsed(Object notificationDate) {
    return Intl.message(
      '$notificationDate is not valid',
      name: 'notificationDateCouldNotBeParsed',
      desc: '',
      args: [notificationDate],
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