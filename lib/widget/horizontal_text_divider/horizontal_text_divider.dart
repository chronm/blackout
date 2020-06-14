import 'package:flutter/material.dart';

class HorizontalTextDivider extends StatelessWidget {
  final String text;

  const HorizontalTextDivider({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
          ),
          Text(text),
          Expanded(
            child: Divider(
              color: Colors.grey[800],
              thickness: 2,
            ),
          )
        ],
      ),
    );
  }
}
