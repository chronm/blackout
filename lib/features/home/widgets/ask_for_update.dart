import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AskForUpdateDialog extends StatelessWidget {
  const AskForUpdateDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).HOME_ASK_FOR_UPDATES_TITLE),
      content: Text(S.of(context).HOME_ASK_FOR_UPDATES_BODY),
      actions: [
        FlatButton(
          child: Text(S.of(context).HOME_ASK_FOR_UPDATES_OKAY),
          onPressed: () => Navigator.pop(context, true),
        ),
        FlatButton(
          child: Text(S.of(context).HOME_ASK_FOR_UPDATES_DENY),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
