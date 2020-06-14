import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/features/speeddial/bloc/speed_dial_bloc.dart';
import 'package:Blackout/features/speeddial/speeddial.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/charge_dialog/charge_dialog.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Icon, Icons, Key, Navigator, StatelessWidget, TextStyle, Widget, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ChargeDial extends StatelessWidget {
  const ChargeDial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SpeedDialBloc, SpeedDialState>(
      bloc: sl<SpeedDialBloc>(),
      listener: (context, state) {
        if (state is GoToHome) {
          Navigator.push(context, RouteBuilder.build(Routes.HomeRoute));
        }
      },
      child: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: sl<ChargeBloc>(),
        builder: (context, state) {
          return BlackoutDial(
            builder: (context) {
              List<SpeedDialChild> children = [
                SpeedDialChild(
                  child: const Icon(Icons.home),
                  backgroundColor: Colors.red,
                  label: S.of(context).SPEEDDIAL_GOTO_HOME,
                  labelStyle: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  onTap: () => sl<SpeedDialBloc>().add(TapOnGotoHome()),
                ),
              ];
              if (state is ShowCharge) {
                Charge charge = state.charge;
                children.addAll([
                  SpeedDialChild(
                    child: const Icon(Icons.add),
                    backgroundColor: Colors.red,
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
                    backgroundColor: Colors.red,
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
                            var siValue = UnitConverter.toSi(Amount.fromInput(value, charge.product.unit)).value;
                            return siValue <= charge.amount && siValue > 0;
                          },
                          callback: (value) async {
                            sl<SpeedDialBloc>().add(TakeFromCharge(charge, value));
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
