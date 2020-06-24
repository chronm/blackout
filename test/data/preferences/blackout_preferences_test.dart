import 'package:Blackout/data/preferences/blackout_preferences.dart';
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
    var home = await preferences.getHome();

    expect(home.id, equals(defaultHomeId));
    expect(home.name, equals(defaultHomeName));
  });

  test('store and retrieve user', () async {
    await preferences.setUser(User(name: defaultUserName, id: defaultUserId));
    var user = await preferences.getUser();

    expect(user.id, equals(defaultUserId));
    expect(user.name, equals(defaultUserName));
  });

  test('store and retrieve version', () async {
    await preferences.setVersion(defaultAppVersion);
    var version = await preferences.getVersion();

    expect(version, equals(defaultAppVersion));
  });
}
