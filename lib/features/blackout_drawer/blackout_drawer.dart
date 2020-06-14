import 'package:Blackout/features/blackout_drawer/bloc/drawer_bloc.dart';
import 'package:Blackout/features/blackout_drawer/widgets/header.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/routes.dart';
import 'package:flutter/material.dart' show BuildContext, Card, Container, Drawer, Icon, Icons, ListTile, ListView, Navigator, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

class BlackoutDrawer extends StatelessWidget {

  const BlackoutDrawer();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerBloc, DrawerState>(
      bloc: sl<DrawerBloc>(),
      listener: (context, state) async{
        if (state is GoToSettings) {
          await Navigator.push(context, RouteBuilder.build(Routes.SettingsRoute));
          sl<DrawerBloc>().add(InitializeDrawer());
        }
      },
      child: Drawer(
        child: BlocBuilder<DrawerBloc, DrawerState>(
          bloc: sl<DrawerBloc>(),
          builder: (context, state) {
            if (state is LoadedDrawer) {
              return ListView(
                children: [
                  Header(
                    username:  state.username,
                  ),
                ]..addAll(
                    state.homes.map(
                      (e) => Card(
                        child: ListTile(
                          title: Text(e.name),
                          leading: state.activeHome == state.homes.indexOf(e) ? Icon(Icons.home) : null,
                        ),
                      ),
                    ),
                  ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
