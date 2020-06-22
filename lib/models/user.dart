import 'dart:convert';

import 'package:Blackout/data/database/database.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

class User {
  String id;
  String name;

  User({this.id, @required this.name});

  User clone() {
    return User(id: id, name: name);
  }

  @override
  bool operator ==(other) {
    return name == other.name;
  }

  factory User.fromEntry(UserEntry entry) {
    return User(
      id: entry.id,
      name: entry.name,
    );
  }

  UserTableCompanion toCompanion({bool active}) {
    return UserTableCompanion(
      id: Value(id),
      name: Value(name),
      active: Value(active),
    );
  }

  factory User.fromJson(String json) {
    if (json == null) return null;
    Map<String, dynamic> map = jsonDecode(json);
    return User(
      id: map["id"],
      name: map["name"],
    );
  }

  String toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
    };
    return jsonEncode(map);
  }
}
