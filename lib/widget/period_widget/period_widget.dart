import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:Blackout/widget/tooltip_icon/tooltip_icon.dart';
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
  String _errorText;
  FocusNode _focusNode = FocusNode();

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
    if (_checked) {
      String input = _controller.text.trim();
      if (input == "") {
        setState(() {
          _errorText = S.of(context).WARN_PERIOD_MUST_NOT_BE_EMPTY;
        });
        _controller.text = "P";
      } else {
        setState(() {
          _period = periodFromISO8601String(input);
          _errorText = _period == null ? S.of(context).WARN_PERIOD_COULD_NOT_BE_PARSED(input) : null;
        });
      }
      if (_controller.selection.start < 1) {
        _controller.selection = TextSelection.fromPosition(TextPosition(offset: 1));
      }
      widget.callback(_period, _errorText != null);
    } else {
      widget.callback(null, false);
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
                focusNode: _focusNode,
                controller: _controller,
                decoration: InputDecoration(
                  labelText: S.of(context).GROUP_BEST_BEFORE,
                  helperText: _period.prettyPrint(context),
                  errorText: _errorText,
                  suffixIcon: TooltipIcon(
                    focusNode: _focusNode,
                    title: S.of(context).GROUP_BEST_BEFORE,
                    tooltip: S.of(context).GROUP_BEST_BEFORE_HELP,
                  ),
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
