import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';

typedef void UnitCallback(UnitEnum unit, double amount, bool checked);

class UnitWidget extends StatefulWidget {
  final UnitEnum initialUnit;
  final double initialRefillLimit;
  final UnitCallback unitCallback;

  UnitWidget({Key key, this.initialUnit, this.unitCallback, this.initialRefillLimit}) : super(key: key);

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  bool _error = false;
  UnitEnum _unit;
  bool _checked;
  double _value;
  String _input;

  @override
  void initState() {
    super.initState();
    _unit = widget.initialUnit;
    _value = widget.initialRefillLimit;
    _checked = widget.initialRefillLimit != null;
    _input = _checked ? UnitConverter.toScientific(Amount.fromSi(_value, _unit)).toString().trim() : "";
  }

  invokeCallback() {
    double value;
    try {
      if (_checked && _input == "") {
        setState(() {
          _error = true;
        });
      } else {
        value = UnitConverter.toSi(Amount.fromInput(_input, _unit)).value;
        setState(() {
          _error = false;
        });
      }
    } on NoSuchMethodError {
      value = null;
      setState(() {
        _error = true;
      });
    } finally {
      widget.unitCallback(_unit, value, _checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 4.4),
            child: CheckedTextField(
              initialChecked: _checked,
              initialValue: _input,
              decoration: InputDecoration(
                labelText: S.of(context).minimumAmount,
                errorText: _error ? S.of(context).amountCouldNotBeParsed(_input) : null,
              ),
              callback: (input, checked) {
                _input = input;
                _checked = checked;
                invokeCallback();
              },
            ),
          ),
        ),
        Container(
          height: 50,
          child: VerticalDivider(
            width: 20,
            thickness: 1.5,
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(left: 4.4),
            child: DropdownButton<UnitEnum>(
              items: UnitEnum.values
                  .map(
                    (u) => DropdownMenuItem(
                      value: u,
                      child: Text(describeEnum(u)),
                    ),
                  )
                  .toList(),
              onChanged: (unit) {
                _unit = unit;
                invokeCallback();
              },
              value: _unit,
            ),
          ),
        ),
      ],
    );
  }
}
