import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../models/batch.dart';
import '../../../widget/scrollable_material_dialog/scrollable_material_dialog.dart';
import 'expiration_date_picker.dart';

typedef BatchSaveAction = Function(Batch batch);

class BatchConfiguration extends StatefulWidget {
  final Batch batch;
  final bool newBatch;
  final BatchSaveAction action;

  const BatchConfiguration({
    Key key,
    @required this.batch,
    @required this.action,
    this.newBatch = false,
  }) : super(key: key);

  @override
  _BatchConfigurationState createState() => _BatchConfigurationState();
}

class _BatchConfigurationState extends State<BatchConfiguration> {
  Batch _batch;
  Batch _oldBatch;
  bool _errorInExpirationDate = false;

  @override
  void initState() {
    super.initState();
    _batch = widget.batch.clone();
    _oldBatch = widget.batch.clone();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableMaterialDialog(
      child: Column(
        children: [
          ExpirationDatePicker(
            initialExpirationDate: _batch.expirationDate,
            callback: (expirationDate, error) {
              setState(() {
                _batch.expirationDate = expirationDate;
                _errorInExpirationDate = error;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FlatButton(
              color: Theme.of(context).accentColor,
              child: Text(S.of(context).GENERAL_SAVE),
              onPressed: !_errorInExpirationDate && (_batch != _oldBatch || widget.newBatch) ? () => widget.action(_batch) : null,
            ),
          ),
        ],
      ),
    );
  }
}
