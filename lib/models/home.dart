import 'dart:convert';

import 'package:Blackout/data/database/database.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

class Home {
  String id;
  String name;

  Home({@required this.id, @required this.name});

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

  HomeTableCompanion toCompanion() {
    return HomeTableCompanion(id: Value(id), name: Value(name));
  }
}
