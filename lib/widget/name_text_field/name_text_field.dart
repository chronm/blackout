import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void NameCallback(String name);

class NameTextField extends StatefulWidget {
  final String initialValue;
  final NameCallback callback;

  NameTextField({Key key, this.initialValue, this.callback}) : super(key: key);

  @override
  _NameTextFieldState createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  TextEditingController _controller = TextEditingController();
  bool _validInput;

  void validateInput(String value) {
    if (value == "") {
      setState(() {
        _validInput = false;
      });
    } else {
      setState(() {
        _validInput = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    validateInput(widget.initialValue);
    _controller.text = widget.initialValue.trim();
    _controller.addListener(() {
      validateInput(_controller.text.trim());
      if (_validInput) {
        widget.callback(_controller.text.trim());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: S.of(context).singular,
        errorText: _validInput ? null : "Must not be empty",
      ),
    );
  }
}
