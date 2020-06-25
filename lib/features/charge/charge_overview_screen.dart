import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../widget/horizontal_text_divider/horizontal_text_divider.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import '../blackout_drawer/blackout_drawer.dart';
import 'bloc/charge_bloc.dart';
import 'widgets/changes_list.dart';
import 'widgets/charge_dial.dart';
import 'widgets/charge_title.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({Key key}) : super(key: key);

  @override
  _ChargeScreenState createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChargeBloc, ChargeState>(
      bloc: sl<ChargeBloc>(),
      listener: (context, state) {},
      child: Scaffold(
        key: _scaffold,
        drawer: BlackoutDrawer(),
        body: ScrollableContainer(
          fullscreen: true,
          child: BlocBuilder<ChargeBloc, ChargeState>(
            bloc: sl<ChargeBloc>(),
            builder: (context, state) {
              if (state is ShowCharge) {
                var charge = state.charge;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ChargeTitle(
                      scaffold: _scaffold,
                      charge: charge,
                    ),
                    HorizontalTextDivider(
                      text: S.of(context).CHANGES,
                    ),
                    ChangesList(
                      charge: charge,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: const ChargeDial(),
      ),
    );
  }
}
