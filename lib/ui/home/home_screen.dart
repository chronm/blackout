import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/speed_dial/speed_dial_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/home_listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/util/charge_extension.dart';
import 'package:Blackout/util/speeddial.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/search_bar/search_bar.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart'
    show BuildContext, Card, Center, Colors, Column, Container, CrossAxisAlignment, Expanded, FontWeight, Hero, Icon, Icons, ListTile, ListView, MainAxisSize, Material, MediaQuery, Row, Scaffold, SingleChildScrollView, State, StatefulWidget, Text, TextStyle, Widget;
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
    return Scaffold(
      body: ScrollableContainer(
        fullscreen: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchBar(
              height: 110.0,
              callback: (searchString) {
                setState(() {
                  this.searchString = searchString;
                });
              },
              child: Container(
                color: Colors.redAccent,
                width: MediaQuery.of(context).size.width,
                height: 110.0,
                child: Center(
                  child: Text(
                    "Blackout",
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              bloc: sl<HomeBloc>(),
              builder: (context, state) {
                if (state is LoadedAll) {
                  if (state.cards.length == 0) {
                    return Center(
                      child: Text(S.of(context).GENERAL_NOTHING_HERE),
                    );
                  }
                  List<HomeListable> cards = state.cards.where((card) => card.title.toLowerCase().contains(searchString)).toList();

                  return Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        HomeListable listable = cards[index];

                        List<Widget> trailing = <Widget>[];
                        if (listable.tooFewAvailable) {
                          trailing.add(
                            Icon(Icons.trending_down),
                          );
                        }
                        if (listable.expired || listable.warn) {
                          trailing.add(
                            Icon(
                              Icons.event,
                              color: listable.status == ChargeStatus.expired ? Colors.redAccent : null,
                            ),
                          );
                        }

                        String status = listable.buildStatus(context);

                        return Hero(
                          tag: listable.id,
                          flightShuttleBuilder: (context, animation, flightDirection, fromHeroContext, toHeroContext) => Material(
                            child: SingleChildScrollView(
                              child: toHeroContext.widget,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              isThreeLine: status != null,
                              title: Text(listable.title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(S.of(context).GENERAL_AMOUNT_AVAILABLE(listable.scientificAmount)), status != null ? Text(status) : null].where((element) => element != null).toList(),
                              ),
                              trailing: Row(
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
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
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
          widget.speedDial.add(TapOnScanEan(ean, context));
        }),
        createProductButton(() => widget.speedDial.add(TapOnCreateProduct(context, null))),
        createGroupButton(() => widget.speedDial.add(TapOnCreateGroup(context))),
      ]),
    );
  }
}
