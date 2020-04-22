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

  /// `en`
  String get _locale {
    return Intl.message(
      'en',
      name: '_locale',
      desc: '',
      args: [],
    );
  }

  /// `Setup`
  String get setup {
    return Intl.message(
      'Setup',
      name: 'setup',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam`
  String get welcomeMessage {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `How do you want do be called. This will be used to identify you in your home.`
  String get setYourUsername {
    return Intl.message(
      'How do you want do be called. This will be used to identify you in your home.',
      name: 'setYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to join an existing household or create a new one?`
  String get setYourHome {
    return Intl.message(
      'Do you want to join an existing household or create a new one?',
      name: 'setYourHome',
      desc: '',
      args: [],
    );
  }

  /// `Simply scan the QR Code on another device to join the household.`
  String get joinHome {
    return Intl.message(
      'Simply scan the QR Code on another device to join the household.',
      name: 'joinHome',
      desc: '',
      args: [],
    );
  }

  /// `What should be the name of your household?`
  String get createHome {
    return Intl.message(
      'What should be the name of your household?',
      name: 'createHome',
      desc: '',
      args: [],
    );
  }

  /// `Name of your household`
  String get nameOfYourHousehold {
    return Intl.message(
      'Name of your household',
      name: 'nameOfYourHousehold',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
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
      'Singular',
      name: 'singular',
      desc: '',
      args: [],
    );
  }

  String get plural {
    return Intl.message(
      'Plural',
      name: 'plural',
      desc: '',
      args: [],
    );
  }

  String get modifyCategory {
    return Intl.message(
      'Modify Category',
      name: 'modifyCategory',
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

  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
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
      'Disabled $field from $from',
      name: 'disabledField',
      desc: '',
      args: [field, from],
    );
  }

  String enabledField(Object field, Object to) {
    return Intl.message(
      'Enabled $field with $to',
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