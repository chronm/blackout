import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/checked_text_field/checked_text_field.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

typedef void PeriodCallback(Period period);

class PeriodTextField extends StatefulWidget {
  final Period initialPeriod;
  final PeriodCallback callback;

  PeriodTextField({Key key, this.initialPeriod, this.callback}) : super(key: key);

  @override
  _PeriodTextFieldState createState() => _PeriodTextFieldState();
}

class _PeriodTextFieldState extends State<PeriodTextField> {
  void invokeCallback(String value, bool checked) {
    widget.callback(checked ? periodFromISO8601String(value) : null);
  }

  @override
  Widget build(BuildContext context) {
    return CheckedTextField(
      initialChecked: widget.initialPeriod != null,
      initialValue: (widget.initialPeriod.toString()),
      decoration: InputDecoration(labelText: S.of(context).warnMe),
      callback: invokeCallback,
    );
  }
}
