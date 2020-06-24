import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        Icon,
        Icons,
        Key,
        Navigator,
        StatelessWidget,
        TextStyle,
        Theme,
        Widget,
        showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/unit/unit.dart';
import '../../../routes.dart';
import '../../../util/charge_extension.dart';
import '../../../widget/charge_dialog/charge_dialog.dart';
import '../../speeddial/bloc/speed_dial_bloc.dart';
import '../../speeddial/speeddial.dart';
import '../bloc/charge_bloc.dart';

class ChargeDial extends StatelessWidget {
  const ChargeDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) {
        if (state is GoToHome) {
          Navigator.pushNamed(context, Routes.home);
        }
      },
      child: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: sl<ChargeBloc>(),
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
              if (state is ShowCharge) {
                var charge = state.charge;
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.add),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_ADD_TO_CHARGE,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => ChargeDialog(
                          title: S.of(context).DIALOG_ADD_TO_CHARGE,
                          callback: (value) async {
                            sl<SpeedDialBloc>().add(AddToCharge(charge, value));
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.remove),
                    backgroundColor: Theme.of(context).accentColor,
                    label: S.of(context).SPEEDDIAL_TAKE_FROM_CHARGE,
                    labelStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => ChargeDialog(
                          title: S.of(context).DIALOG_TAKE_FROM_CHARGE,
                          initialValue: charge.scientificAmount,
                          validation: (value) {
                            var siValue = UnitConverter.toSi(Amount.fromInput(
                                    value, charge.product.unit))
                                .value;
                            return siValue <= charge.amount && siValue > 0;
                          },
                          callback: (value) async {
                            sl<SpeedDialBloc>()
                                .add(TakeFromCharge(charge, value));
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
