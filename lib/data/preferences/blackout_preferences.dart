import 'dart:async';

import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart' show Preferences;

class BlackoutPreferences {
  final SharedPreferences _sharedPreference;

  BlackoutPreferences(this._sharedPreference);

  User _user;
  Home _home;
  String _version;

  Future<User> getUser() async {
    if (_user == null) {
      _user = User.fromJson(_sharedPreference.getString(Preferences.user));
    }

    return _user;
  }

  Future<bool> setUser(User user) async {
    _user = user;
    return _sharedPreference.setString(Preferences.user, user.toJson());
  }

  Future<Home> getHome() async {
    if (_home == null) {
      _home = Home.fromJson(_sharedPreference.getString(Preferences.home));
    }

    return _home;
  }

  Future<bool> setHome(Home home) async {
    _home = home;
    return _sharedPreference.setString(Preferences.home, home.toJson());
  }

  Future<String> getVersion() async {
    if (_version == null) {
      _version = _sharedPreference.getString(Preferences.version);
    }

    return _version;
  }

  Future<bool> setVersion(String version) async {
    _version = version;
    return _sharedPreference.setString(Preferences.version, version);
  }
}
