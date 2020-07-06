import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../typedefs.dart';

class SetupUser extends StatefulWidget {
  final StringCallback callback;
  final FocusNode focus;

  const SetupUser({
    Key key,
    @required this.callback,
    @required this.focus,
  }) : super(key: key);

  @override
  _SetupUserState createState() => _SetupUserState();
}

class _SetupUserState extends State<SetupUser> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {});
        widget.callback(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(S.of(context).SETUP_STEP_CREATE_USERNAME_DESCRIPTION, style: TextStyle(fontSize: 16.0)),
        TextField(
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.go,
          focusNode: widget.focus,
          decoration: InputDecoration(
            errorText: _controller.text == "" ? S.of(context).SETUP_STEP_CREATE_USERNAME_ERROR : null,
          ),
          controller: _controller,
        ),
      ],
    );
  }
}
