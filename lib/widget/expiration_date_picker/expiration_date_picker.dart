import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

typedef void ExpirationDateCallback(LocalDateTime expirationDate, bool error);

class ExpirationDatePicker extends StatefulWidget {
  final LocalDateTime initialExpirationDate;
  final ExpirationDateCallback callback;

  ExpirationDatePicker({Key key, @required this.initialExpirationDate, @required this.callback}) : super(key: key);

  @override
  _ExpirationDatePickerState createState() => _ExpirationDatePickerState();
}

class _ExpirationDatePickerState extends State<ExpirationDatePicker> {
  bool _checked;
  TextEditingController _controller;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialExpirationDate != null;
    _controller = TextEditingController(text: DateFormat.yMd().format(_checked ? widget.initialExpirationDate.toDateTimeLocal() : LocalDateTime.now().toDateTimeLocal()));
    _controller.addListener(() {
      invokeCallback();
    });
  }

  void invokeCallback() {
    LocalDateTime dateTime;
    try {
      dateTime = LocalDateTime.dateTime(DateFormat.yMd().parse(_controller.text));
      setState(() {
        _error = false;
      });
    } on FormatException {
      setState(() {
        _error = true;
      });
    } on AssertionError {
      setState(() {
        _error = true;
      });
    }
    widget.callback(_checked ? dateTime : null, _error);
  }

  @override
  Widget build(BuildContext context) {
    return Checkable(
      initialChecked: _checked,
      checkedCallback: (context) => Expanded(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: _controller.text != "" ? DateFormat.yMd().parse(_controller.text) : DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: LocalDateTime.now().addYears(100).toDateTimeLocal(),
                );
                _controller.text = DateFormat.yMd().format(picked);
                invokeCallback();
              },
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  errorText: _error ? S.of(context).expirationDateCouldNotBeParsed(_controller.text) : null,
                ),
              ),
            ),
          ],
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          S.of(context).expirationDate,
          textAlign: TextAlign.center,
        ),
      ),
      callback: (checked) {
        setState(() {
          _checked = checked;
        });
        invokeCallback();
      },
    );
  }
}
