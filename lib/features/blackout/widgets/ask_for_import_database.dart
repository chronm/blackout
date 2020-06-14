import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

class AskForImportDatabaseDialog extends StatelessWidget {
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
