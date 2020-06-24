import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../setup_screen.dart';
import 'setup_page.dart';

typedef SetupHomeCallback = void Function(SetupHomeAction action);

class SetupHome extends StatefulWidget {
  final SetupHomeCallback callback;

  const SetupHome({
    Key key,
    @required this.callback,
  }) : super(key: key);

  @override
  _SetupHomeState createState() => _SetupHomeState();
}

class _SetupHomeState extends State<SetupHome> {
  SetupHomeAction _action;

  @override
  Widget build(BuildContext context) {
    return SetupPage(
      padding: 100,
      description: S.of(context).SETUP_HOME_CARD_TITLE,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Radio<SetupHomeAction>(
                value: SetupHomeAction.create,
                groupValue: _action,
                onChanged: (value) {
                  setState(() {
                    _action = value;
                  });
                  widget.callback(value);
                },
              ),
              Text(S.of(context).SETUP_CREATE_HOME),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: <Widget>[
              // ignore: missing_required_param
              Radio<SetupHomeAction>(
                value: SetupHomeAction.join,
                groupValue: _action,
//                onChanged: (value) {
//                  setState(() {
//                    _action = value;
//                  });
//                  widget.callback(value);
//                },
              ),
              Text(S.of(context).SETUP_JOIN_HOME),
            ],
          ),
        ],
      ),
    );
  }
}
