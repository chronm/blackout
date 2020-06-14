import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void DescriptionCallback(String description);

class DescriptionTextField extends StatefulWidget {
  final String initialValue;
  final DescriptionCallback callback;

  const DescriptionTextField({
    Key key,
    @required this.initialValue,
    @required this.callback,
  }) : super(key: key);

  @override
  _DescriptionTextFieldState createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  TextEditingController _controller = TextEditingController();
  bool _error;

  void callCallback(String value) {
    if (value == "") {
      setState(() {
        _error = true;
      });
      widget.callback(null);
    } else {
      setState(() {
        _error = false;
      });
      widget.callback(value);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue.trim();
    _error = _controller.text == null;
    _controller.addListener(() {
      callCallback(_controller.text.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: S.of(context).PRODUCT_DESCRIPTION,
            errorText: _error ? S.of(context).WARN_DESCRIPTION_MUST_NOT_BE_EMPTY : null,
          ),
        ),
      ),
    );
  }
}
