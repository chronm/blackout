import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../models/unit/unit.dart';

typedef UnitCallback = Function(UnitEnum unit);

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
    var enums = List.from(UnitEnum.values)..sort((a, b) => enumToString(context, a).compareTo(enumToString(context, b)));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SizedBox(
            width: 100,
            child: DropdownButtonFormField<UnitEnum>(
              decoration: InputDecoration(
                labelText: S.of(context).GENERAL_UNIT,
              ),
              items: enums
                  .map((u) => DropdownMenuItem<UnitEnum>(
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
      ),
    );
  }
}
