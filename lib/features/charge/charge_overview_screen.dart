import 'package:Blackout/features/blackout_drawer/blackout_drawer.dart';
import 'package:Blackout/features/charge/bloc/charge_bloc.dart';
import 'package:Blackout/features/charge/widgets/changes_list.dart';
import 'package:Blackout/features/charge/widgets/charge_dial.dart';
import 'package:Blackout/features/charge/widgets/charge_title.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart' show BuildContext, Container, GlobalKey, Key, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargeOverviewScreen extends StatefulWidget {
  const ChargeOverviewScreen({Key key}) : super(key: key);

  @override
  _ChargeOverviewScreenState createState() => _ChargeOverviewScreenState();
}

class _ChargeOverviewScreenState extends State<ChargeOverviewScreen> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey();

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
                Charge charge = state.charge;
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
