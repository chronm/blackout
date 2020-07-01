import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Theme, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../../util/batch_extension.dart';
import '../../../widget/batch_dialog/batch_dialog.dart';
import '../../speeddial/bloc/speed_dial_bloc.dart';
import '../../speeddial/speeddial.dart';
import '../bloc/batch_bloc.dart';

class BatchDial extends StatelessWidget {
  const BatchDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
        }
      },
      child: BlocBuilder<BatchBloc, BatchState>(
        bloc: sl<BatchBloc>(),
        builder: (context, state) {
          return BlackoutDial(
            builder: (context) {
              var children = <SpeedDialChild>[
                SpeedDialChild(
                  child: const Icon(Icons.home),
                  backgroundColor: Theme.of(context).accentColor,
                  label: S.of(context).SPEEDDIAL_GOTO_HOME,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnGotoHome()),
                ),
              ];
              if (state is ShowBatch) {
                var batch = state.batch;
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.add),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_ADD_TO_BATCH,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => BatchDialog(
                          title: S.of(context).DIALOG_ADD_TO_BATCH,
                          callback: (value) async {
                            sl<SpeedDialBloc>().add(AddToBatch(batch, value));
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.remove),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_TAKE_FROM_BATCH,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => BatchDialog(
                          title: S.of(context).DIALOG_TAKE_FROM_BATCH,
                          initialValue: batch.scientificAmount,
                          validation: (value) {
                            var siValue = UnitConverter.toSi(Amount.fromInput(value, batch.product.unit)).value;
                            return siValue <= batch.amount && siValue > 0;
                          },
                          callback: (value) async {
                            sl<SpeedDialBloc>().add(TakeFromBatch(batch, value));
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  )
                ]);
              }
              return children;
            },
          );
        },
      ),
    );
  }
}
