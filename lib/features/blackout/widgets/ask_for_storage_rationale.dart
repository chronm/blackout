import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AskForStorageRationaleDialog extends StatelessWidget {
  const AskForStorageRationaleDialog({Key key}): super(key: key);

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
