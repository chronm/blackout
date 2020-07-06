import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../typedefs.dart';

class CreateHome extends StatefulWidget {
  final StringCallback callback;
  final FocusNode focus;

  const CreateHome({
    Key key,
    @required this.callback,
    @required this.focus,
  }) : super(key: key);

  @override
  _CreateHomeState createState() => _CreateHomeState();
}

class _CreateHomeState extends State<CreateHome> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        setState(() {

        });
        widget.callback(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(S.of(context).SETUP_CREATE_HOME_CARD_TITLE, style: TextStyle(fontSize: 16.0)),
        TextField(
          textInputAction: TextInputAction.go,
          textCapitalization: TextCapitalization.words,
          focusNode: widget.focus,
          decoration: InputDecoration(
            errorText: _controller.text == "" ? S.of(context).SETUP_HOME_NAME_ERROR : null,
          ),
          controller: _controller,
        ),
      ],
    );
  }
}
