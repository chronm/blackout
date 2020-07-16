import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

import '../../../generated/l10n.dart';
import '../../../widget/checkable/checkable.dart';

typedef ExpirationDateCallback = void Function(LocalDate expirationDate, bool error);

class ExpirationDatePicker extends StatefulWidget {
  final LocalDate initialExpirationDate;
  final ExpirationDateCallback callback;

  const ExpirationDatePicker({
    Key key,
    @required this.initialExpirationDate,
    @required this.callback,
  }) : super(key: key);

  @override
  _ExpirationDatePickerState createState() => _ExpirationDatePickerState();
}

class _ExpirationDatePickerState extends State<ExpirationDatePicker> {
  bool _checked;
  TextEditingController _controller;
  String _errorText;

  @override
  void initState() {
    super.initState();
    _checked = widget.initialExpirationDate != null;
    _controller = TextEditingController(text: DateFormat.yMd().format(_checked ? widget.initialExpirationDate.toDateTimeUnspecified() : LocalDate.today().toDateTimeUnspecified()));
    _controller.addListener(invokeCallback);
  }

  void invokeCallback() {
    if (_checked) {
      var input = _controller.text.trim();
      LocalDate dateTime;
      try {
        dateTime = LocalDate.dateTime(DateFormat.yMd().parse(input));
        setState(() {
          _errorText = null;
        });
      } on FormatException {
        setState(() {
          _errorText = S.of(context).WARN_EXPIRATION_DATE_COULD_NOT_BE_PARSED(input);
        });
      }
      widget.callback(dateTime, _errorText != null);
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
          checkedCallback: (context) => Expanded(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    var picked = await showDatePicker(
                      context: context,
                      initialDate: _controller.text != "" ? DateFormat.yMd().parse(_controller.text) : DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: LocalDate.today().addYears(100).toDateTimeUnspecified(),
                    );
                    _controller.text = DateFormat.yMd().format(picked);
                    invokeCallback();
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      errorText: _errorText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          uncheckedCallback: (context) => Expanded(
            child: Text(
              S.of(context).BATCH_EXPIRATION_DATE,
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
