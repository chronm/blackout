import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef UsernameCallback(String value, bool error);

class UsernameField extends StatefulWidget {
  final String initialValue;
  final UsernameCallback callback;

  UsernameField({Key key, this.initialValue, this.callback}) : super(key: key);

  @override
  _UsernameFieldState createState() => _UsernameFieldState();
}

class _UsernameFieldState extends State<UsernameField> {
  TextEditingController _controller = TextEditingController();
  bool _error;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue.trim();
    _error = _controller.text == null;
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
            labelText: S.of(context).SETTINGS_USERNAME,
            errorText: _error ? S.of(context).WARN_USERNAME_MUST_NOT_BE_EMPTY : null,
          ),
        ),
      ),
    );
  }
}
