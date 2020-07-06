import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../typedefs.dart';
import '../../../widget/tooltip_icon/tooltip_icon.dart';

class SetupDatabasePassword extends StatefulWidget {
  final StringCallback callback;
  final FocusNode focus;

  const SetupDatabasePassword({
    Key key,
    @required this.callback,
    @required this.focus,
  }) : super(key: key);

  @override
  _SetupDatabasePasswordState createState() => _SetupDatabasePasswordState();
}

class _SetupDatabasePasswordState extends State<SetupDatabasePassword> {
  TextEditingController _controller;
  bool _error = true;
  bool _help = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        if (_controller.text == "") {
          setState(() {
            _error = true;
            _help = false;
          });
        } else {
          if (RegExp(r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!"§$%&\/()=?`{[\]\}\\´^°+\*~\#\-_.:,;@€<>|']).{16,}$''').hasMatch(_controller.text)) {
            setState(() {
              _error = false;
              _help = false;
            });
          } else {
            setState(() {
              _error = false;
              _help = true;
            });
          }
        }
        widget.callback(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(S.of(context).SETUP_STEP_CREATE_PASSWORD_DESCRIPTION, style: TextStyle(fontSize: 16.0)),
        TextField(
          obscureText: true,
          textInputAction: TextInputAction.go,
          focusNode: widget.focus,
          decoration: InputDecoration(
            errorText: _error ? S.of(context).SETUP_STEP_CREATE_PASSWORD_ERROR : null,
            helperText: _help ? S.of(context).SETUP_STEP_CREATE_PASSWORD_HELP : null,
            suffixIcon: TooltipIcon(
              title: S.of(context).SETUP_STEP_CREATE_PASSWORD_HINT_TITLE,
              tooltip: S.of(context).SETUP_STEP_CREATE_PASSWORD_HINT_DESCRIPTION,
              focusNode: widget.focus,
            ),
          ),
          controller: _controller,
        ),
      ],
    );
  }
}
