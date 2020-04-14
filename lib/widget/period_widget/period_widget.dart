import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/period_text_field/period_text_field.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';

typedef void PeriodCallback(Period period);

class PeriodWidget extends StatefulWidget {
  final Period initialPeriod;
  final PeriodCallback callback;

  PeriodWidget({Key key, this.callback, this.initialPeriod}) : super(key: key);

  @override
  _PeriodWidgetState createState() => _PeriodWidgetState();
}

class _PeriodWidgetState extends State<PeriodWidget> {
  Period _period;

  @override
  void initState() {
    super.initState();
    _period = widget.initialPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PeriodTextField(
          initialPeriod: widget.initialPeriod,
          callback: (period) {
            widget.callback(period);
            setState(() {
              _period = period;
            });
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.8),
          child: Center(
            child: Text(
              _period.prettyPrint(context),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
