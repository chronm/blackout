import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart' show AnimatedIcons, BuildContext, Card, Center, CircleBorder, Colors, Column, Container, Curves, Icon, IconThemeData, Icons, ListTile, ListView, MainAxisSize, Navigator, SafeArea, Scaffold, State, StatefulWidget, Text, TextStyle, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final SpeedDialBloc speedDial = sl<SpeedDialBloc>();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchString = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: LoadingAppBar<HomeBloc, HomeState>(
          title: "Blackout",
          bloc: sl<HomeBloc>(),
          searchCallback: (search) {
            setState(() {
              searchString = search.toLowerCase();
            });
          },
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: sl<HomeBloc>(),
          builder: (context, state) {
            if (state is LoadedAll) {
              if (state.cards.length == 0) {
                return Center(
                  child: Text(
                    "Nothing here",
                  ),
                );
              }
              List<HomeListable> cards = state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList();

              return ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  HomeListable listable = cards[index];

                  List<Widget> trailing = <Widget>[];
                  if (listable.expiredOrNotification) {
                    trailing.add(
                      Icon(Icons.event),
                    );
                  }
                  if (listable.tooFewAvailable) {
                    trailing.add(
                      Icon(Icons.trending_down),
                    );
                  }

                  Widget card = Card(
                    child: ListTile(
                      title: Text(listable.title),
                      subtitle: Text(S.of(context).available(listable.subtitle)),
                      trailing: Column(
                        children: trailing,
                        mainAxisSize: MainAxisSize.min,
                      ),
                      onTap: () async {
                        if (listable is Group) {
                          sl<HomeBloc>().add(TapOnGroup(listable, context));
                        } else if (listable is Product) {
                          sl<HomeBloc>().add(TapOnProduct(listable, context));
                        }
                      },
                    ),
                  );

                  return card;
                },
              );
            }
            return Container();
          },
        ),
        floatingActionButton: createSpeedDial([
          scanButton(() async {
            String ean;
            if (isEmulator) {
              ean = "someEan";
            } else {
              var options = ScanOptions(restrictFormat: [BarcodeFormat.ean8, BarcodeFormat.ean13]);
              var result = await BarcodeScanner.scan(options: options);
              ean = result.rawContent;
            }
            widget.speedDial.add(ScannedEan(ean, context));
          }),
          createProductButton(() => widget.speedDial.add(TapOnCreateProduct(context))),
          createGroupButton(() => widget.speedDial.add(TapOnCreateGroup(context))),
        ]),
      ),
    );
  }
}
