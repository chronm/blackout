import 'package:Blackout/features/charge_overview/bloc/charge_bloc.dart';
import 'package:Blackout/features/charge_overview/widgets/charge_configuration.dart';
import 'package:Blackout/features/group_overview/bloc/group_bloc.dart';
import 'package:Blackout/features/group_overview/widgets/group_configuration.dart';
import 'package:Blackout/features/product_overview/bloc/product_bloc.dart';
import 'package:Blackout/features/product_overview/widgets/product_configuration.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/widget/charge_dialog/charge_dialog.dart';
import 'package:flutter/material.dart' show AnimatedIcons, BuildContext, CircleBorder, Colors, Curves, Dialog, Icon, IconThemeData, Icons, Key, Navigator, StatelessWidget, TextStyle, VoidCallback, Widget, required, showDialog;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'bloc/speed_dial_bloc.dart';

typedef List<SpeedDialChild> BlackoutDialBuilder(BuildContext context);

class BlackoutDial extends StatelessWidget {
  final BlackoutDialBuilder builder;

  BlackoutDial({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.redAccent,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: builder(context),
    );
  }
}

SpeedDialChild scanButton(VoidCallback callback, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.center_focus_weak),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_SCAN,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createChargeButton(VoidCallback callback, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.insert_drive_file),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_CREATE_CHARGE,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createGroupButton(VoidCallback callback, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.create_new_folder),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_CREATE_GROUP,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild goToHomeButton(VoidCallback callback, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.home),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_GOTO_HOME,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild addToChargeButton(Charge charge, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_ADD_TO_CHARGE,
      labelStyle: TextStyle(
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
    );

SpeedDialChild takeFromChargeButton(Charge charge, BuildContext context) => SpeedDialChild(
      child: Icon(Icons.remove),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_TAKE_FROM_CHARGE,
      labelStyle: TextStyle(
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
    );
