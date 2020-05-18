import 'package:Blackout/bloc/item/item_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/widget/loading_app_bar/loading_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemOverviewScreen extends StatefulWidget {
  final ItemBloc _bloc = sl<ItemBloc>();

  ItemOverviewScreen({Key key}) : super(key: key);

  @override
  _ItemOverviewScreenState createState() => _ItemOverviewScreenState();
}

class _ItemOverviewScreenState extends State<ItemOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LoadingAppBar<ItemBloc, ItemState>(
        bloc: widget._bloc,
        titleResolver: (state) => state is ShowItem ? state.item.buildTitle(context) : "",
        titleCallback: (state) {
          if (state is ShowItem) {
//            Navigator.push(context, RouteBuilder.build(Routes.))
          }
        },
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        bloc: widget._bloc,
        builder: (context, state) {
          if (state is ShowItem) {
            return ListView.builder(
              itemCount: state.item.changes.length,
              itemBuilder: (context, index) {
                Change change = state.item.changes[index];

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
