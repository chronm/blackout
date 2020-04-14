import 'package:Blackout/models/unit.dart';
import 'package:Blackout/util/double_extension.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void UnitCallback(double amount);

class UnitTextField extends StatefulWidget {
  final double initialValue;
  final UnitCallback callback;
  final Unit unit;

  UnitTextField({Key key, this.initialValue, this.callback, this.unit}) : super(key: key);

  @override
  _UnitTextFieldState createState() => _UnitTextFieldState();
}

class _UnitTextFieldState extends State<UnitTextField> {
  TextEditingController _controller = TextEditingController();
  bool checked;

  BaseUnit baseUnitFromSymbol(String symbol) {
    RegExp regexp = RegExp(r"((\d*[.,])*(\d*))(t|kg|g|mg)");
    switch (widget.unit) {
      case Unit.weight:
        return Weight.fromString(regexp.firstMatch(symbol).group(4));
      case Unit.unitless:
        return Unitless();
    }
  }

  double amountFromString(String value) {
    RegExp regexp = RegExp(r"((\d*[.,])*(\d*))(t|kg|g|mg)");
    return double.parse(regexp.firstMatch(value).group(1));
  }

  @override
  void initState() {
    super.initState();
    checked = widget.initialValue != null;
    _controller.text = widget.initialValue.format();
    _controller.addListener(() {
      widget.callback(baseUnitFromSymbol(_controller.text).toSI(amountFromString(_controller.text)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CheckedTextField(
      initialChecked: checked,
      controller: _controller,
      decoration: InputDecoration(
        labelText: "Initial value",
      ),
    );
  }
}
