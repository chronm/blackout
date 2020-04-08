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