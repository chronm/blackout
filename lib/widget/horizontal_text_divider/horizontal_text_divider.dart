import 'package:flutter/material.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String text;

  HorizontalTextDivider({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(),
          ),
          Text(text),
          Expanded(
            child: Divider(),
          )
        ],
      ),
    );
  }
}
