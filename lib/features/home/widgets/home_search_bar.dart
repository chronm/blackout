import 'package:Blackout/typedefs.dart';
import 'package:Blackout/widget/search_bar/search_bar.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final StringCallback searchCallback;

  HomeSearchBar({Key key, this.scaffold, this.searchCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      scaffold: scaffold,
      height: 110.0,
      callback: searchCallback,
      child: Container(
        color: Colors.redAccent,
        width: MediaQuery.of(context).size.width,
        height: 110.0,
        child: Center(
          child: Text(
            "Blackout",
            style: TextStyle(color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
