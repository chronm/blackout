import 'package:Blackout/bloc/charge/charge_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/util/string_extension.dart';
import 'package:Blackout/util/time_machine_extension.dart';
import 'package:Blackout/widget/horizontal_text_divider/horizontal_text_divider.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Center, Container, Key, ListTile, ListView, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      body: ScrollableContainer(
        fullscreen: true,
        child: BlocBuilder<ChargeBloc, ChargeState>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is ShowCharge) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  TitleCard(
                    title: S.of(context).UNIT_CREATED_AT(state.charge.creationDate.prettyPrintShortDifference(context)).capitalize(),
                    tag: state.charge.id,
                    available: S.of(context).GENERAL_AMOUNT_AVAILABLE(state.charge.scientificAmount),
                    event: state.charge.buildStatus(context),
                    productName: state.charge.product.title,
                    groupName: state.charge.product.group?.title,
                    modifyAction: () => widget.bloc.add(TapOnShowChargeConfiguration(state.charge, context)),
                    changesAction: () => widget.bloc.add(TapOnShowChargeChanges(state.charge.modelChanges, context)),
                  ),
                  HorizontalTextDivider(
                    text: S.of(context).CHANGES,
                  ),
                  Expanded(
                    child: state.charge.changes.length == 0
                        ? Center(
                            child: Text("Nothing here"),
                          )
                        : ListView.builder(
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
                          ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: BlocBuilder<ChargeBloc, ChargeState>(
        bloc: widget.bloc,
        builder: (context, state) {
          List<SpeedDialChild> children = [
            goToHomeButton(() => widget.speedDial.add(TapOnGotoHome(context))),
          ];
          if (state is ShowCharge) {
            children.add(addToChargeButton(() => widget.speedDial.add(TapOnAddToCharge(context, state.charge))));
            children.add(takeFromChargeButton(() => widget.speedDial.add(TapOnTakeFromCharge(context, state.charge))));
          }
          return createSpeedDial(children);
        },
      ),
    );
  }
}
