import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/widget/expiration_date_picker/expiration_date_picker.dart';
import 'package:Blackout/widget/notification_date_picker/notification_date_picker.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';

class ChargeDetailsScreen extends StatefulWidget {
  final ChargeBloc bloc = sl<ChargeBloc>();
  final Charge charge;

  ChargeDetailsScreen(this.charge, {Key key}) : super(key: key);

  @override
  _ChargeDetailsScreenState createState() => _ChargeDetailsScreenState();
}

class _ChargeDetailsScreenState extends State<ChargeDetailsScreen> {
  Charge _charge;
  bool _errorInExpirationDate = false;
  bool _errorInNotificationDate = false;

  @override
  void initState() {
    super.initState();
    _charge = widget.charge.clone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: FLAppBarTitle(
          title: S.of(context).modifyCharge,
          titleStyle: TextStyle(
            fontSize: 20,
          ),
          subtitle: widget.charge.hierarchy(context),
          subtitleStyle: TextStyle(
            fontSize: 15,
          ),
          layout: FLAppBarTitleLayout.vertical,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: !_errorInExpirationDate && !_errorInNotificationDate && _charge != widget.charge
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
    );
  }
}
