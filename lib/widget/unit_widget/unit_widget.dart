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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: DropdownButton<UnitEnum>(
            items: UnitEnum.values.map((u) => DropdownMenuItem(value: u, child: Text(describeEnum(u)))).toList(),
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
