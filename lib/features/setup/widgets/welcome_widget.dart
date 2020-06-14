import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Text(
            S.of(context).SETUP_WELCOME_CARD_TITLE,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
