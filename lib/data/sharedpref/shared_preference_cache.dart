import 'dart:async';

import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

import 'constants/preferences.dart' show Preferences;

class SharedPreferenceCache {
  final Future<SharedPreferences> _sharedPreference;

  SharedPreferenceCache(this._sharedPreference);

  User _user;
  Home _home;

  Future<User> getUser() async {
    if (_user == null) {
      _user = User.fromJson((await _sharedPreference).getString(Preferences.user));
    }

    return _user;
  }

  Future<bool> setUser(User user) async {
    _user = user;
    return (await _sharedPreference).setString(Preferences.user, user.toJson());
  }

  Future<Home> getHome() async {
    if (_home == null) {
      _home = Home.fromJson((await _sharedPreference).getString(Preferences.home));
    }

    return _home;
  }

  Future<bool> setHome(Home home) async {
    _home = home;
    return (await _sharedPreference).setString(Preferences.home, home.toJson());
  }
}
