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
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),
      children: children,
    );

SpeedDialChild scanButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.center_focus_weak),
      backgroundColor: Colors.red,
      label: 'Scan',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createChargeButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.insert_drive_file),
      backgroundColor: Colors.red,
      label: 'Create Item',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createProductButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.insert_drive_file),
      backgroundColor: Colors.red,
      label: 'Create Product',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild createGroupButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.create_new_folder),
      backgroundColor: Colors.red,
      label: 'Create Group',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild goToHomeButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.home),
      backgroundColor: Colors.red,
      label: 'Home',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild addToChargeButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.add),
      backgroundColor: Colors.red,
      label: 'Add',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );

SpeedDialChild takeFromChargeButton(VoidCallback callback) =>
    SpeedDialChild(
      child: Icon(Icons.remove),
      backgroundColor: Colors.red,
      label: 'Remove',
      labelStyle: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      onTap: callback,
    );
