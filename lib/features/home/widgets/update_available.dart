import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class UpdateAvailableDialog extends StatelessWidget {
  const UpdateAvailableDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).HOME_UPDATE_AVAILABLE_TITLE),
      content: Text(S.of(context).HOME_UPDATE_AVAILABLE_BODY),
      actions: [
        FlatButton(
          child: Text(S.of(context).HOME_UPDATE_AVAILABLE_OKAY),
          onPressed: () => Navigator.pop(context, true),
        ),
        FlatButton(
          child: Text(S.of(context).HOME_UPDATE_AVAILABLE_DENY),
          onPressed: () => Navigator.pop(context, false),
        ),
      ],
    );
  }
}
