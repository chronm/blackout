import 'package:flutter/material.dart';

typedef CheckedCallback(bool checked);

class Checkable extends StatefulWidget {
  final bool initialChecked;
  final WidgetBuilder checkedCallback;
  final WidgetBuilder uncheckedCallback;
  final CheckedCallback callback;

  Checkable({Key key, @required this.checkedCallback, @required this.uncheckedCallback, @required this.initialChecked, this.callback}) : super(key: key);

  @override
  _CheckableState createState() => _CheckableState();
}

class _CheckableState extends State<Checkable> {
  bool _checked;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _checked ? widget.checkedCallback(context) : widget.uncheckedCallback(context),
        Container(
          height: 59,
          child: VerticalDivider(
            width: 20,
            thickness: 1.5,
          ),
        ),
        Checkbox(
          value: _checked,
          onChanged: (checked) {
            setState(() {
              _checked = checked;
            });
            widget.callback?.call(_checked);
          },
        ),
      ],
    );
  }
}
