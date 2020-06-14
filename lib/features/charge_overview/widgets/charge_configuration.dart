import 'package:Blackout/features/charge_overview/widgets/expiration_date_picker.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/widget/scrollable_material_dialog/scrollable_material_dialog.dart';
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
    return ScrollableMaterialDialog(
      child: Column(
        children: [
          ExpirationDatePicker(
            initialExpirationDate: _charge.expirationDate,
            callback: (expirationDate, error) {
              setState(() {
                _charge.expirationDate = expirationDate;
                _errorInExpirationDate = error;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FlatButton(
              color: Colors.redAccent,
              child: Text(S.of(context).GENERAL_SAVE),
              onPressed: !_errorInNotificationDate && !_errorInExpirationDate && (_charge != _oldCharge || widget.newCharge) ? () => widget.action(_charge) : null,
            ),
          ),
        ],
      ),
    );
  }
}
