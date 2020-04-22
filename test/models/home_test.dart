import 'dart:convert';

import 'package:Blackout/models/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  test('(Home.fromJson) create a home from bare json', () async {
    String json = '{"id": "id", "name": "name"}';

    Home home = Home.fromJson(json);

    expect(home.id, equals("id"));
    expect(home.name, equals("name"));
  });

  test('(ToJson) turn a home to json', () async {
    Home home = createDefaultHome();

    String json = home.toJson();

    expect(jsonDecode(json)["id"], equals(DEFAULT_HOME_ID));
    expect(jsonDecode(json)["name"], equals(DEFAULT_HOME_NAME));
  });
}
