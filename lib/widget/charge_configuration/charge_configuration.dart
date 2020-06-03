import 'package:Blackout/models/charge.dart';
import 'package:Blackout/widget/expiration_date_picker/expiration_date_picker.dart';
import 'package:Blackout/widget/notification_date_picker/notification_date_picker.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart';

typedef ChargeSaveAction(Charge charge);

class ChargeConfiguration extends StatefulWidget {
  final Charge charge;
  final bool newCharge;
  final ChargeSaveAction action;

  ChargeConfiguration({Key key, this.charge, this.newCharge = false, this.action}) : super(key: key);

  @override
  _ChargeConfigurationState createState() => _ChargeConfigurationState();
}

class _ChargeConfigurationState extends State<ChargeConfiguration> {
  Charge _charge;
  Charge _oldCharge;
  bool _errorInExpirationDate = false;
  bool _errorInNotificationDate = false;

  @override
  void initState() {
    super.initState();
    _charge = widget.charge.clone();
    _oldCharge = widget.charge.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.0),
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.8),
                    child: ExpirationDatePicker(
                      initialExpirationDate: _charge.expirationDate,
                      callback: (expirationDate, error) {
                        setState(() {
                          _charge.expirationDate = expirationDate;
                          _errorInExpirationDate = error;
                        });
                      },
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.8),
                    child: NotificationDatePicker(
                      initialNotificationDate: _charge.notificationDate,
                      callback: (notificationDate, error) {
                        setState(() {
                          _charge.notificationDate = notificationDate;
                          _errorInNotificationDate = error;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.8),
                  child: FlatButton(
                    color: Colors.redAccent,
                    child: Text("save"),
                    onPressed: _charge.isValid() && !_errorInNotificationDate && !_errorInExpirationDate && (_charge != _oldCharge || widget.newCharge) ? () => widget.action(_charge) : null,
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}
