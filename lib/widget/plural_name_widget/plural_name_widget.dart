import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';

typedef void PluralNameCallback(String pluralName);

class PluralNameWidget extends StatefulWidget {
  final String initialValue;
  final PluralNameCallback callback;

  PluralNameWidget({Key key, this.initialValue, @required this.callback}) : super(key: key);

  @override
  _PluralNameWidgetState createState() => _PluralNameWidgetState();
}

class _PluralNameWidgetState extends State<PluralNameWidget> {
  TextEditingController _controller;
  bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialValue != null;
    _controller = TextEditingController(text: widget.initialValue);
    _controller.addListener(() {
      invokeCallback();
    });
  }

  void invokeCallback() {
    widget.callback(_checked ? _controller.text : null);
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: widget.initialValue != null,
      checkedCallback: (context) => Expanded(
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: S.of(context).plural,
          ),
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          S.of(context).plural,
          textAlign: TextAlign.center,
        ),
      ),
      callback: (checked) {
        setState(() {
          _checked = checked;
        });
        invokeCallback();
      },
    );
  }
}
