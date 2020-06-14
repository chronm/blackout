import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

typedef void PeriodCallback(Period period, bool error);

class PeriodWidget extends StatefulWidget {
  final Period initialPeriod;
  final PeriodCallback callback;

  const PeriodWidget({
    Key key,
    @required this.callback,
    @required this.initialPeriod,
  }) : super(key: key);

  @override
  _PeriodWidgetState createState() => _PeriodWidgetState();
}

class _PeriodWidgetState extends State<PeriodWidget> {
  TextEditingController _controller;
  Period _period;
  bool _checked;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _period = widget.initialPeriod;
    _checked = _period != null;
    _controller = TextEditingController(text: _checked ? _period.toString() : "");
    _controller.addListener(() {
      invokeCallback();
    });
  }

  void invokeCallback() {
    if (_controller.text == "" && _checked) {
      setState(() {
        _error = true;
      });
      widget.callback(null, true);
    } else {
      setState(() {
        _period = periodFromISO8601String(_controller.text);
        _error = _period == null;
      });
      widget.callback(_checked ? _period : null, _error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Checkable(
          initialChecked: _checked,
          checkedCallback: (context) {
            return Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: S.of(context).GROUP_BEST_BEFORE,
                  helperText: _period.prettyPrint(context),
                  errorText: _error ? "Error" : null,
                ),
              ),
            );
          },
          uncheckedCallback: (context) => Expanded(
            child: Text(
              S.of(context).GROUP_BEST_BEFORE,
              textAlign: TextAlign.center,
            ),
          ),
          callback: (checked) {
            setState(() {
              _checked = checked;
            });
            invokeCallback();
          },
        ),
      ),
    );
  }
}
