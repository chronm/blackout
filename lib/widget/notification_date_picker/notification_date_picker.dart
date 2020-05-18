import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/widget/checkable/checkable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

typedef void NotificationDateCallback(LocalDateTime notificationDate, bool error);

class NotificationDatePicker extends StatefulWidget {
  final LocalDateTime initialNotificationDate;
  final NotificationDateCallback callback;

  NotificationDatePicker({Key key, @required this.initialNotificationDate, @required this.callback}) : super(key: key);

  @override
  _NotificationDatePickerState createState() => _NotificationDatePickerState();
}

class _NotificationDatePickerState extends State<NotificationDatePicker> {
  bool _checked;
  TextEditingController _controller;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialNotificationDate != null;
    _controller = TextEditingController(text: DateFormat.yMd().format(_checked ? widget.initialNotificationDate.toDateTimeLocal() : LocalDateTime.now().toDateTimeLocal()));
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
                  errorText: _error ? S.of(context).notificationDateCouldNotBeParsed(_controller.text) : null,
                ),
              ),
            ),
          ],
        ),
      ),
      uncheckedCallback: (context) => Expanded(
        child: Text(
          S.of(context).notificationDate,
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
