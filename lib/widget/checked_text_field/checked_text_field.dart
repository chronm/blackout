import 'package:flutter/material.dart';

typedef void CheckedTextFieldCallback(String value, bool checked);

class CheckedTextField extends StatefulWidget {
  final bool initialChecked;
  final String initialValue;
  final InputDecoration decoration;
  final CheckedTextFieldCallback callback;

  CheckedTextField({
    Key key,
    this.decoration,
    this.initialChecked = false,
    this.initialValue = "",
    this.callback,
  }) : super(key: key);

  @override
  _CheckedTextFieldState createState() => _CheckedTextFieldState();
}

class _CheckedTextFieldState extends State<CheckedTextField> {
  TextEditingController _controller = TextEditingController();
  bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialChecked;
    _controller.text = widget.initialValue;
    _controller.addListener(invokeCallback);
  }

  invokeCallback() {
    widget.callback(_controller.text.trim(), _checked);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            enabled: _checked,
            controller: _controller,
            decoration: widget.decoration,
          ),
        ),
        Checkbox(
          onChanged: (value) {
            setState(() {
              _checked = value;
            });
            invokeCallback();
          },
          value: _checked,
        ),
      ],
    );
  }
}
