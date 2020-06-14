import 'package:Blackout/features/setup/widgets/setup_page.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/typedefs.dart';
import 'package:flutter/material.dart';

class SetupUser extends StatefulWidget {
  final StringCallback callback;
  final FocusNode focus;

  SetupUser({
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
        widget.callback(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SetupPage(
      description: S.of(context).SETUP_USERNAME_CARD_TITLE,
      child: TextField(
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.go,
        focusNode: widget.focus,
        decoration: InputDecoration(
          labelText: S.of(context).SETUP_USERNAME,
        ),
        controller: _controller,
      ),
    );
  }
}
