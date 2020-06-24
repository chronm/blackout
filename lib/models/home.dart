import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

import '../data/database/database.dart';

class Home {
  String id;
  String name;

  Home({@required this.id, @required this.name});

  @override
  bool operator ==(dynamic other) {
    return id == other.id && name == other.name;
  }

  factory Home.fromJson(String json) {
    if (json == null) return null;
    Map<String, dynamic> map = jsonDecode(json);

    return Home(id: map["id"], name: map["name"]);
  }

  String toJson() {
    return jsonEncode({"id": id, "name": name});
  }

  factory Home.fromEntry(HomeEntry entry) {
    return Home(id: entry.id, name: entry.name);
  }

  HomeTableCompanion toCompanion({bool active}) {
    return HomeTableCompanion(
      id: Value(id),
      name: Value(name),
      active: Value(active),
    );
  }

  @override
  int get hashCode => super.hashCode;

}
