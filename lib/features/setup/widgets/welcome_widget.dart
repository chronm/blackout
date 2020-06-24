import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Text(
            S.of(context).SETUP_WELCOME_CARD_TITLE,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
