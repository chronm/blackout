import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../blackout_test_base.dart';

void main() {
  BlackoutPreferences preferences;
  setUp(() {
    preferences = BlackoutPreferences(SharedPreferencesMock());
  });

  test('store and retrieve home', () async {
    await preferences.setHome(createDefaultHome());
    Home home = await preferences.getHome();

    expect(home.id, equals(DEFAULT_HOME_ID));
    expect(home.name, equals(DEFAULT_HOME_NAME));
  });

  test('store and retrieve user', () async {
    await preferences.setUser(User(name: DEFAULT_USER_NAME, id: DEFAULT_USER_ID));
    User user = await preferences.getUser();

    expect(user.id, equals(DEFAULT_USER_ID));
    expect(user.name, equals(DEFAULT_USER_NAME));
  });

  test('store and retrieve version', () async {
    await preferences.setVersion(DEFAULT_APP_VERSION);
    String version = await preferences.getVersion();

    expect(version, equals(DEFAULT_APP_VERSION));
  });
}
