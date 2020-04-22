import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/material.dart';

typedef void PluralNameCallback(String pluralName);

class PluralNameWidget extends StatefulWidget {
  final String initialValue;
  final PluralNameCallback callback;

  PluralNameWidget({Key key, @required this.initialValue, @required this.callback}) : super(key: key);

  @override
  _PluralNameWidgetState createState() => _PluralNameWidgetState();
}

class _PluralNameWidgetState extends State<PluralNameWidget> {
  void invokeCallback(String value, bool checked) {
    widget.callback(checked ? value : null);
  }

  @override
  Widget build(BuildContext context) {
    return CheckedTextField(
      initialChecked: widget.initialValue != null,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        labelText: S.of(context).plural,
      ),
      callback: invokeCallback,
    );
  }
}
