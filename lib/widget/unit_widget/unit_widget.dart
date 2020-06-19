import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef UnitCallback(UnitEnum unit);

class UnitWidget extends StatefulWidget {
  final UnitEnum initialUnit;
  final UnitCallback callback;

  const UnitWidget({
    Key key,
    @required this.callback,
    @required this.initialUnit,
  }) : super(key: key);

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  UnitEnum _unit;

  @override
  void initState() {
    super.initState();
    _unit = widget.initialUnit ?? UnitEnum.values[0];
  }

  String enumToString(BuildContext context, UnitEnum unit) {
    switch (unit) {
      case UnitEnum.unitless:
        return "------";
      case UnitEnum.weight:
        return S.of(context).UNITENUM_WEIGHT;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    List<UnitEnum> enums = List.from(UnitEnum.values)..sort((a, b) => enumToString(context, a).compareTo(enumToString(context, b)));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownButton<UnitEnum>(
            items: enums
                .map((u) => DropdownMenuItem(
                      value: u,
                      child: Text(enumToString(context, u)),
                    ))
                .toList(),
            onChanged: (unit) {
              setState(() {
                _unit = unit;
              });
              widget.callback(unit);
            },
            value: _unit,
          ),
        ),
      ),
    );
  }
}
