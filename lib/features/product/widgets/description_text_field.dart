import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void DescriptionCallback(String description, bool error);

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
  String _errorText;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue.trim();
    _controller.addListener(() {
      invokeCallback();
    });
  }

  void invokeCallback() {
    String input = _controller.text.trim();
    if (input == "") {
      setState(() {
        _errorText = S.of(context).WARN_DESCRIPTION_MUST_NOT_BE_EMPTY;
      });
      widget.callback(null, true);
    } else {
      setState(() {
        _errorText = null;
      });
      widget.callback(input, false);
    }
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
            errorText: _errorText,
          ),
        ),
      ),
    );
  }
}
