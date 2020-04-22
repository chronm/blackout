import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/preferences/constants/preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blackout_test_base.dart';

class SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  SharedPreferences sharedPreferences;
  BlackoutPreferences preferences;

  setUp(() {
    sharedPreferences = SharedPreferencesMock();
    preferences = BlackoutPreferences(sharedPreferences);
  });

  test('set a user and then get it from cache', () async {
    await preferences.setUser(createDefaultUser());

    verify(sharedPreferences.setString(Preferences.user, argThat(isA<String>()))).called(1);

    await preferences.getUser();

    verifyNever(sharedPreferences.getString(Preferences.user));
  });

  test('set a home and then get it from cache', () async {
    await preferences.setHome(createDefaultHome());

    verify(sharedPreferences.setString(Preferences.home, argThat(isA<String>()))).called(1);

    await preferences.getHome();

    verifyNever(sharedPreferences.getString(Preferences.home));
  });

  test('Get a user from sharedPreferences', () async {
    SharedPreferences.setMockInitialValues({Preferences.user: createDefaultUser()});
    await preferences.getUser();

    verify(sharedPreferences.getString(Preferences.user)).called(1);
  });

  test('Get a home from sharedPreferences', () async {
    SharedPreferences.setMockInitialValues({Preferences.home: createDefaultHome()});
    await preferences.getHome();

    verify(sharedPreferences.getString(Preferences.home)).called(1);
  });
}
