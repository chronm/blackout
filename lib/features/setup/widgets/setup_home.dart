import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../typedefs.dart';

class SetupHome extends StatefulWidget {
  final StringCallback callback;
  final FocusNode focus;

  const SetupHome({
    Key key,
    @required this.callback,
    @required this.focus,
  }) : super(key: key);

  @override
  _SetupHomeState createState() => _SetupHomeState();
}

class _SetupHomeState extends State<SetupHome> {
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
      children: <Widget>[
        Text(S.of(context).SETUP_STEP_CREATE_HOME_DESCRIPTION, style: TextStyle(fontSize: 16.0)),
        TextField(
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.words,
          focusNode: widget.focus,
          decoration: InputDecoration(
            errorText: _controller.text == "" ? S.of(context).SETUP_STEP_CREATE_HOME_ERROR : null,
          ),
          controller: _controller,
        ),
      ],
    );
  }
}
