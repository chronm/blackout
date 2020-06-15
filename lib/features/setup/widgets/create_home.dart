import 'package:Blackout/features/setup/widgets/setup_page.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/typedefs.dart';
import 'package:Blackout/widget/relative_height_container/relative_height_container.dart';
import 'package:flutter/material.dart';

class CreateHome extends StatefulWidget {
  final StringCallback callback;
  final VoidCallback finishAction;

  const CreateHome({
    Key key,
    @required this.callback,
    @required this.finishAction,
  }) : super(key: key);

  @override
  _CreateHomeState createState() => _CreateHomeState();
}

class _CreateHomeState extends State<CreateHome> {
  TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        widget.callback(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SetupPage(
      description: S.of(context).SETUP_CREATE_HOME_CARD_TITLE,
      child: Column(
        children: <Widget>[
          TextField(
            textInputAction: TextInputAction.go,
            textCapitalization: TextCapitalization.words,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: S.of(context).SETUP_CREATE_HOME,
            ),
            controller: _controller,
          ),
          RelativeHeightContainer(factor: 0.01),
          FlatButton(
            color: Theme.of(context).accentColor,
            onPressed: () {
              _focusNode.unfocus();
              widget.finishAction();
            },
            child: Text(S.of(context).SETUP_FINISH),
          ),
        ],
      ),
    );
  }
}
