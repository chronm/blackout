import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/app_bar_title/app_bar_title.dart';
import 'package:Blackout/widget/expiration_date_picker/expiration_date_picker.dart';
import 'package:Blackout/widget/notification_date_picker/notification_date_picker.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class ChargeDetailsScreen extends StatefulWidget {
  final ChargeBloc bloc = sl<ChargeBloc>();
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  ChargeDetailsScreen({Key key}) : super(key: key);

  @override
  _ChargeDetailsScreenState createState() => _ChargeDetailsScreenState();
}

class _ChargeDetailsScreenState extends State<ChargeDetailsScreen> {
  Charge _oldCharge;
  Charge _charge;
  bool _errorInExpirationDate = false;
  bool _errorInNotificationDate = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.bloc.state is ShowCharge) {
      setState(() {
        _oldCharge = (widget.bloc.state as ShowCharge).charge.clone();
        _charge = _oldCharge.clone();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(
          title: S.of(context).modifyCharge,
          subtitle: _charge.hierarchy(context),
          layout: AppBarTitleLayout.vertical,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: !_errorInExpirationDate && !_errorInNotificationDate && _charge != _oldCharge
                ? () {
                    widget.bloc.add(SaveCharge(_charge));
                    Navigator.pop(context);
                  }
                : null,
          )
        ],
      ),
      body: ScrollableContainer(
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
          ],
        ),
      ),
      floatingActionButton: createSpeedDial([
        goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
      ]),
    );
  }
}
