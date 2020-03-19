import 'package:Blackout/widget/relative_height_container/relative_height_container.dart';
import 'package:flutter/material.dart';

class BlackoutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: <Widget>[
          Text(
            "Blackout",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 60,
              color: Colors.white10,
            ),
          ),
        ],
      ),
    );
  }
}
