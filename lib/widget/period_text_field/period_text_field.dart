import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

typedef void PeriodCallback(Period period);

class PeriodTextField extends StatefulWidget {
  final Period initialPeriod;
  final PeriodCallback callback;

  PeriodTextField({Key key, this.initialPeriod, this.callback})
      : super(key: key);

  @override
  _PeriodTextFieldState createState() => _PeriodTextFieldState();
}

class _PeriodTextFieldState extends State<PeriodTextField> {
  TextEditingController _periodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _periodController.text =
        widget.initialPeriod != null ? widget.initialPeriod.toString() : "";
    _periodController.addListener(
      () {
        widget.callback(_periodController.text != ""
            ? periodFromISO8601String(_periodController.text)
            : null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CheckedTextField(
      initialChecked: widget.initialPeriod != null,
      controller: _periodController,
      decoration: InputDecoration(labelText: "Period"),
      onChanged: (value) {
        if (value == "") {
          _periodController.text = "P";
          _periodController.selection = TextSelection.fromPosition(
              TextPosition(offset: _periodController.text.length));
        }
      },
    );
  }
}
