import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

class AskForStorageRationaleDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_TITLE),
      content: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_BODY),
      actions: [
        FlatButton(
          child: Text(S.of(context).PERMISSIONS_STORAGE_RATIONALE_OKAY),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
