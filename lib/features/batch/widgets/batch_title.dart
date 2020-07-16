import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../util/batch_extension.dart';
import '../../../util/string_extension.dart';
import '../../../widget/model_changes_widget/model_changes_widget.dart';
import '../../../widget/title_card/title_card.dart';
import '../bloc/batch_bloc.dart';
import 'batch_configuration.dart';

class BatchTitle extends StatelessWidget {
  final Batch batch;
  final GlobalKey<ScaffoldState> scaffold;

  const BatchTitle({
    Key key,
    @required this.batch,
    @required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var title = batch.expirationDate != null ? S.of(context).BATCH_GOOD_UNTIL(DateFormat.yMd().format(batch.expirationDate.toDateTimeUnspecified())) : S.of(context).BATCH_CREATED_AT(DateFormat.yMd().format(batch.creationDate.toDateTimeUnspecified()));
    return TitleCard(
      scaffold: scaffold,
      title: title.capitalize(),
      tag: batch.id,
      available: S.of(context).GENERAL_AMOUNT_AVAILABLE(batch.scientificAmount),
      event: batch.buildStatus(context),
      productName: batch.product.title,
      groupName: batch.product.group?.title,
      modifyAction: () => showDialog(
        context: context,
        builder: (context) => BatchConfiguration(
          batch: batch,
          action: (batch) {
            Navigator.pop(context);
            sl<BatchBloc>().add(SaveBatch(batch));
          },
        ),
      ),
      changesAction: () => showDialog(
        context: context,
        builder: (context) => ModelChangesWidget(changes: batch.modelChanges),
      ),
    );
  }
}
