import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Container, Key, ListTile, ListView, Navigator, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class ChargeOverviewScreen extends StatefulWidget {
  final ChargeBloc _bloc = sl<ChargeBloc>();

  ChargeOverviewScreen({Key key}) : super(key: key);

  @override
  _ChargeOverviewScreenState createState() => _ChargeOverviewScreenState();
}

class _ChargeOverviewScreenState extends State<ChargeOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<ChargeBloc, ChargeState>(
        bloc: widget._bloc,
        titleResolver: (state) => state is ShowCharge ? state.charge.buildTitle(context) : "",
        titleCallback: (state) {
          if (state is ShowCharge) {
            Navigator.push(context, RouteBuilder.build(Routes.chargeDetailsRoute(charge: state.charge)));
          }
        },
        subtitleResolver: (state) {
          if (state is ShowCharge) {
            return Text(state.charge.hierarchy(context));
          }
          return Container();
        },
      ),
      body: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowCharge) {
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
    );
  }
}
