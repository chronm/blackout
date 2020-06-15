import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void NameCallback(String name, bool error);

class NameTextField extends StatefulWidget {
  final String initialValue;
  final NameCallback callback;

  const NameTextField({
    Key key,
    @required this.initialValue,
    @required this.callback,
  }) : super(key: key);

  @override
  _NameTextFieldState createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {
  TextEditingController _controller = TextEditingController();
  bool _error;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue.trim();
    _error = _controller.text == "";
    _controller.addListener(() {
      invokeCallback(_controller.text.trim());
    });
  }

  void invokeCallback(String value) {
    setState(() {
      _error = value == "";
    });
    widget.callback(_error ? null : value, _error);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: S.of(context).GROUP_NAME,
            errorText: _error ? S.of(context).WARN_NAME_MUST_NOT_BE_EMPTY : null,
          ),
        ),
      ),
    );
  }
}
