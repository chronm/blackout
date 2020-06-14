import 'package:Blackout/features/charge_overview/bloc/charge_bloc.dart';
import 'package:Blackout/features/charge_overview/widgets/charge_configuration.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/widget/model_changes_widget/model_changes_widget.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChargeTitle extends StatelessWidget {
  final Charge charge;
  final GlobalKey<ScaffoldState> scaffold;

  ChargeTitle({
    Key key,
    @required this.charge,
    @required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleCard(
      scaffold: scaffold,
      title: S.of(context).UNIT_CREATED_AT(DateFormat.yMd().format(charge.creationDate.toDateTimeUnspecified())).capitalize(),
      tag: charge.id,
      available: S.of(context).GENERAL_AMOUNT_AVAILABLE(charge.scientificAmount),
      event: charge.buildStatus(context),
      productName: charge.product.title,
      groupName: charge.product.group?.title,
      modifyAction: () => showDialog(
        context: context,
        builder: (context) => ChargeConfiguration(
          charge: charge,
          action: (charge) {
            Navigator.pop(context);
            sl<ChargeBloc>().add(SaveCharge(charge));
          },
        ),
      ),
      changesAction: () => showDialog(
        context: context,
        builder: (context) => ModelChangesWidget(changes: charge.modelChanges),
      ),
    );
  }
}
