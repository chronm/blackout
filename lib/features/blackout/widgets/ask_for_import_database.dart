import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class AskForImportDatabaseDialog extends StatefulWidget {
  final bool wrongPassword;

  const AskForImportDatabaseDialog({Key key, this.wrongPassword}) : super(key: key);

  @override
  _AskForImportDatabaseDialogState createState() => _AskForImportDatabaseDialogState();
}

class _AskForImportDatabaseDialogState extends State<AskForImportDatabaseDialog> {
  final TextEditingController _controller = TextEditingController();
  bool enableButtons;
  int timeLeft;

  @override
  void initState() {
    super.initState();
    if (widget.wrongPassword) {
      timeLeft = 0;
      enableButtons = true;
    } else {
      timeLeft = 10;
      enableButtons = false;
      Stream.periodic(Duration(seconds: 1), (i) => 10 - i).take(11).forEach((element) => setState(() => timeLeft = element));
      Future.delayed(Duration(seconds: 11)).then((value) => setState(() => enableButtons = true));
    }
    enableButtons = widget.wrongPassword ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).MAIN_IMPORT_DATABASE_TITLE),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(S.of(context).MAIN_IMPORT_DATABASE_DESCRIPTION),
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              errorText: widget.wrongPassword ? S.of(context).MAIN_IMPORT_DATABASE_ERROR : null,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],
      ),
      actions: [
        timeLeft != 0 ? Text(timeLeft.toString()) : null,
        FlatButton(
          child: Text(S.of(context).MAIN_IMPORT_DATABASE_IGNORE),
          onPressed: enableButtons ? () => Navigator.pop(context, null) : null,
        ),
        FlatButton(
          child: Text(S.of(context).MAIN_IMPORT_DATABASE_IMPORT),
          onPressed: enableButtons && _controller.text != "" ? () => Navigator.pop(context, _controller.text) : null,
        ),
      ]..removeWhere((element) => element == null),
    );
  }
}
