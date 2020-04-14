import 'package:Blackout/models/unit.dart';
import 'package:Blackout/widget/unit_text_field/unit_text_field.dart';
import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';

typedef void UnitCallback(BaseUnit baseUnit);
typedef void AmountCallback(double amount);

class UnitWidget extends StatefulWidget {
  final BaseUnit initialUnit;
  final double initialAmount;
  final UnitCallback unitCallback;
  final AmountCallback amountCallback;

  UnitWidget({Key key, this.initialUnit, this.unitCallback, this.amountCallback, this.initialAmount}) : super(key: key);

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  BaseUnit _baseUnit;

  @override
  void initState() {
    super.initState();
    _baseUnit = widget.initialUnit;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 4.4),
            child: UnitTextField(
              initialValue: widget.initialAmount,
              callback: widget.amountCallback,
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: 2.0,
            child: VerticalDivider(
              color: Colors.redAccent,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 4.4),
          child: DropdownButton<Unit>(
            items: Unit.values.map((u) => DropdownMenuItem(value: u, child: Text(describeEnum(u)))).toList(),
            onChanged: (unit) {
              setState(() {
                _baseUnit = baseUnitFromUnit(Unit.values.firstWhere((u) => u == unit));
              });
              widget.unitCallback(_baseUnit);
            },
            value: _baseUnit.unit,
          ),
        ),
      ],
    );
  }
}
