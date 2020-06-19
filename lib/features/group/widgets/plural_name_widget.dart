import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';

typedef void PluralNameCallback(String pluralName, bool error);

class PluralNameWidget extends StatefulWidget {
  final String initialValue;
  final PluralNameCallback callback;

  const PluralNameWidget({
    Key key,
    @required this.initialValue,
    @required this.callback,
  }) : super(key: key);

  @override
  _PluralNameWidgetState createState() => _PluralNameWidgetState();
}

class _PluralNameWidgetState extends State<PluralNameWidget> {
  TextEditingController _controller;
  String _errorText;
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
    if (_checked) {
      String input = _controller.text.trim();
      setState(() {
        _errorText = input == "" ? S.of(context).WARN_PLURAL_NAME_MUST_NOT_BE_EMPTY : null;
      });
      widget.callback(input, _errorText != null);
    } else {
      widget.callback(null, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Checkable(
          initialChecked: _checked,
          checkedCallback: (context) => Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: S.of(context).GROUP_PLURAL_NAME,
                errorText: _errorText,
              ),
            ),
          ),
          uncheckedCallback: (context) => Expanded(
            child: Text(
              S.of(context).GROUP_PLURAL_NAME,
              textAlign: TextAlign.center,
            ),
          ),
          callback: (checked) {
            setState(() {
              _checked = checked;
            });
            invokeCallback();
          },
        ),
      ),
    );
  }
}
