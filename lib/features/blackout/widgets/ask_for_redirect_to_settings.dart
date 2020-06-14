import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

class AskForRedirectToSettingsDialog extends StatelessWidget {
  const AskForRedirectToSettingsDialog({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_TITLE),
      content: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_BODY),
      actions: [
        FlatButton(
          child: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_NOPE),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text(S.of(context).PERMISSIONS_STORAGE_PERMANENTLY_OKAY),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
