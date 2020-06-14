import 'package:flutter/material.dart';

class BlackoutHeader extends StatelessWidget {
  const BlackoutHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: <Widget>[
          const Text(
            "Blackout",
            textAlign: TextAlign.center,
            style: const TextStyle(
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
