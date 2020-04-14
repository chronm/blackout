import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/material.dart';

typedef void PluralNameCallback(String pluralName);

class PluralNameWidget extends StatefulWidget {
  final String initialValue;
  final PluralNameCallback callback;

  PluralNameWidget(
      {Key key, @required this.initialValue, @required this.callback})
      : super(key: key);

  @override
  _PluralNameWidgetState createState() => _PluralNameWidgetState();
}

class _PluralNameWidgetState extends State<PluralNameWidget> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue;
    }
    _controller.addListener(() =>
        widget.callback(_controller.text != "" ? _controller.text : null));
  }

  @override
  Widget build(BuildContext context) {
    return CheckedTextField(
      initialChecked: widget.initialValue != null,
      controller: _controller,
      decoration: InputDecoration(
        labelText: S.of(context).plural,
      ),
    );
  }
}
