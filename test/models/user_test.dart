import 'dart:convert';

import 'package:Blackout/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../blackout_test_base.dart';

void main() {
  test('(User.fromJson) create user from json', () async {
    String json = '{"id": "id", "name": "name"}';

    User user = User.fromJson(json);

    expect(user.id, equals("id"));
    expect(user.name, equals("name"));
  });

  test('(ToJson) get json from user', () async {
    User user = createDefaultUser();

    String json = user.toJson();

    expect(jsonDecode(json)["id"], DEFAULT_USER_ID);
    expect(jsonDecode(json)["name"], DEFAULT_USER_NAME);
  });
}
