import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Container, Key, ListTile, ListView, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargeOverviewScreen extends StatefulWidget {
  final ChargeBloc bloc = sl<ChargeBloc>();
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  ChargeOverviewScreen({Key key}) : super(key: key);

  @override
  _ChargeOverviewScreenState createState() => _ChargeOverviewScreenState();
}

class _ChargeOverviewScreenState extends State<ChargeOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<ChargeBloc, ChargeState>(
        bloc: widget.bloc,
        titleResolver: (state) => state is ShowCharge ? state.charge.buildTitle(context) : "",
        titleCallback: (state) {
          if (state is ShowCharge) {
            Navigator.push(context, RouteBuilder.build(Routes.ChargeDetailsRoute));
          }
        },
        subtitleResolver: (state) => state is ShowCharge ? state.charge.hierarchy(context) : "",
        returnAction: () => Navigator.pop(context),
      ),
      body: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is ShowCharge) {
            if (state.charge.changes.length == 0) {
              return Center(
                child: Text(
                  "Nothing here",
                ),
              );
            }
            return ListView.builder(
              itemCount: state.charge.changes.length,
              itemBuilder: (context, index) {
                Change change = state.charge.changes[index];

                return Card(
                  child: ListTile(
                    title: Text(change.buildTitle(context)),
                    subtitle: Text(change.subtitle),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: widget.bloc,
        builder: (context, state) {
          if (state is ShowCharge) {
            return createSpeedDial(
              [
                goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
                addToChargeButton(
                  () => widget.speedDial.add(
                    TapOnAddToCharge(
                      context,
                      state.charge,
                    ),
                  ),
                ),
                takeFromChargeButton(
                  () => widget.speedDial.add(
                    TapOnTakeFromCharge(
                      context,
                      state.charge,
                    ),
                  ),
                ),
              ],
            );
          }
          return createSpeedDial([
            goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
          ]);
        },
      ),
    );
  }
}
