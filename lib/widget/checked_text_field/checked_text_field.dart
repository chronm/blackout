import 'package:flutter/material.dart';

class CheckedTextField extends StatefulWidget {
  final bool initialChecked;
  final TextEditingController controller;
  final InputDecoration decoration;
  final ValueChanged onChanged;

  CheckedTextField(
      {Key key,
      this.controller,
      this.decoration,
      this.onChanged,
      this.initialChecked})
      : super(key: key);

  @override
  _CheckedTextFieldState createState() => _CheckedTextFieldState();
}

class _CheckedTextFieldState extends State<CheckedTextField> {
  bool enabled = true;
  String valueBackup;

  @override
  void initState() {
    super.initState();
    enabled = widget.initialChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            enabled: enabled,
            controller: widget.controller,
            decoration: widget.decoration,
            onChanged: widget.onChanged,
          ),
        ),
        Checkbox(
          onChanged: (value) {
            setState(() {
              if (value == false) {
                valueBackup = widget.controller.text;
                widget.controller.text = "";
              }
              if (value == true) {
                widget.controller.text = valueBackup;
              }
              enabled = value;
            });
          },
          value: enabled,
        ),
      ],
    );
  }
}
