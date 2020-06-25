import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

import '../data/database/database.dart';

class User {
  String id;
  String name;

  User({this.id, @required this.name});

  User clone() {
    return User(id: id, name: name);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
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
    var map = <String, dynamic>{
      "id": id,
      "name": name,
    };
    return jsonEncode(map);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => super.hashCode;
}
