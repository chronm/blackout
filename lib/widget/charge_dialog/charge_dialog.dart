import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void ChargeCallback(String value);
typedef bool ValidationCallback(String value);

class ChargeDialog extends StatefulWidget {
  final ChargeCallback callback;
  final ValidationCallback validation;
  final String initialValue;
  final String title;

  ChargeDialog({Key key, this.callback, this.initialValue, this.validation, this.title}) : super(key: key);

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
    bool validate = widget.validation != null ? widget.validation(_controller.text) : false;
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
