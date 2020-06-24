import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../typedefs.dart';

typedef ValidationCallback = bool Function(String value);

class ChargeDialog extends StatefulWidget {
  final StringCallback callback;
  final ValidationCallback validation;
  final String initialValue;
  final String title;

  const ChargeDialog({
    Key key,
    @required this.callback,
    @required this.title,
    this.validation,
    this.initialValue,
  }) : super(key: key);

  @override
  _ChargeDialogState createState() => _ChargeDialogState();
}

class _ChargeDialogState extends State<ChargeDialog> {
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
    var validate =
        widget.validation != null ? widget.validation(_controller.text) : true;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        autofocus: true,
        controller: _controller,
      ),
      actions: [
        FlatButton(
          child: Text(S.of(context).DIALOG_CANCEL_BUTTON),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text(S.of(context).DIALOG_ACCEPT_BUTTON),
          onPressed: validate
              ? () {
                  widget.callback(_controller.text);
                }
              : null,
        ),
      ],
    );
  }
}
