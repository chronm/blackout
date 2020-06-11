import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget createSpeedDial(List<SpeedDialChild> children) =>
    SpeedDial(
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
      children: children,
    );

SpeedDialChild scanButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.center_focus_weak),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_SCAN,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createChargeButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.insert_drive_file),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_CREATE_CHARGE,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createProductButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.insert_drive_file),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_CREATE_PRODUCT,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createGroupButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.create_new_folder),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_CREATE_GROUP,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild goToHomeButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.home),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_GOTO_HOME,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild addToChargeButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_ADD_TO_CHARGE,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild takeFromChargeButton(VoidCallback callback, BuildContext context) =>
    SpeedDialChild(
      child: Icon(Icons.remove),
      backgroundColor: Colors.red,
      label: S.of(context).SPEEDDIAL_TAKE_FROM_CHARGE,
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );
