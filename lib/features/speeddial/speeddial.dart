import 'package:flutter/material.dart' show AnimatedIcons, BuildContext, CircleBorder, Colors, Curves, IconThemeData, Key, StatelessWidget, Theme, Widget, required;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

typedef BlackoutDialBuilder = List<SpeedDialChild> Function(BuildContext context);

class BlackoutDial extends StatelessWidget {
  final BlackoutDialBuilder builder;

  const BlackoutDial({
    Key key,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: const IconThemeData(size: 22.0),
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: const CircleBorder(),
      children: builder(context),
    );
  }
}
