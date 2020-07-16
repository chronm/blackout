import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/unit/unit.dart';
import '../../typedefs.dart';

enum BatchMode { take, add }

class BatchDialog extends StatefulWidget {
  final StringCallback callback;
  final String initialValue;
  final String title;
  final BatchMode mode;
  final UnitEnum unit;

  const BatchDialog({
    Key key,
    @required this.callback,
    @required this.title,
    @required this.mode,
    @required this.unit,
    this.initialValue,
  }) : super(key: key);

  @override
  _BatchDialogState createState() => _BatchDialogState();
}

class _BatchDialogState extends State<BatchDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    String errorText;
    try {
      var siValue = UnitConverter.toSi(Amount.fromInput(_controller.text, widget.unit)).value;
      if (widget.mode == BatchMode.take) {
        if (siValue > UnitConverter.toSi(Amount.fromInput(widget.initialValue, widget.unit)).value) {
          errorText = S.of(context).WARN_BATCH_TOO_MUCH;
        } else {
          errorText = null;
        }
      }
      // ignore: avoid_catching_errors
    } on NoSuchMethodError {
      errorText = S.of(context).WARN_AMOUNT_COULD_NOT_BE_PARSED(_controller.text);
    }
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        autofocus: true,
        controller: _controller,
        decoration: InputDecoration(errorText: errorText),
      ),
      actions: [
        FlatButton(
          child: Text(S.of(context).DIALOG_CANCEL_BUTTON),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(S.of(context).DIALOG_ACCEPT_BUTTON),
          onPressed: errorText == null
              ? () {
                  widget.callback(_controller.text);
                }
              : null,
        ),
      ],
    );
  }
}
