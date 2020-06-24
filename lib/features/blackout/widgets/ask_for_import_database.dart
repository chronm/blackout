import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AskForImportDatabaseDialog extends StatelessWidget {
  const AskForImportDatabaseDialog({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).MAIN_IMPORT_DATABASE),
      actions: [
        FlatButton(
          child: Text(S.of(context).MAIN_IMPORT_DATABASE_IGNORE),
          onPressed: () => Navigator.pop(context, false),
        ),
        FlatButton(
          child: Text(S.of(context).MAIN_IMPORT_DATABASE_IMPORT),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
