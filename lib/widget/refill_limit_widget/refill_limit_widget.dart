import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';

typedef void RefillLimitCallback(double amount, bool error);

class RefillLimitWidget extends StatefulWidget {
  final UnitEnum initialUnit;
  final double initialRefillLimit;
  final RefillLimitCallback callback;

  RefillLimitWidget({Key key, this.initialUnit, this.callback, this.initialRefillLimit}) : super(key: key);

  @override
  _RefillLimitWidgetState createState() => _RefillLimitWidgetState();
}

class _RefillLimitWidgetState extends State<RefillLimitWidget> {
  TextEditingController _controller;
  bool _error = false;
  UnitEnum _unit;
  bool _checked;

  @override
  void initState() {
    super.initState();
    _unit = widget.initialUnit;
    _checked = widget.initialRefillLimit != null;
    _controller = TextEditingController(text: UnitConverter.toScientific(Amount.fromSi(widget.initialRefillLimit, _unit)).toString().trim());
    _controller.addListener(() {
      invokeCallback();
    });
  }

  void invokeCallback() {
    double value;
    try {
      if (_checked) {
        if (_controller.text == "") {
          setState(() {
            _error = true;
          });
        } else {
          value = UnitConverter.toSi(Amount.fromInput(_controller.text, _unit)).value;
          setState(() {
            _error = false;
          });
        }
      }
    } on NoSuchMethodError {
      value = null;
      setState(() {
        _error = true;
      });
    } finally {
      widget.callback(value, _error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: _checked,
      checkedCallback: (context) => Expanded(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: S.of(context).minimumAmount,
                  errorText: _error ? S.of(context).amountCouldNotBeParsed(_controller.text) : null,
                ),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          S.of(context).minimumAmount,
          textAlign: TextAlign.center,
        ),
      ),
      callback: (checked) {
        setState(() {
          _checked = checked;
          invokeCallback();
        });
      },
    );
  }
}
