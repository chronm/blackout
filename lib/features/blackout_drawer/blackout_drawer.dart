import 'package:flutter/material.dart' show Align, Alignment, BuildContext, Card, Column, Container, Drawer, Expanded, Icon, Icons, ListTile, ListView, MediaQuery, Navigator, StatelessWidget, Text, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../routes.dart';
import 'cubit/drawer_cubit.dart';
import 'widgets/header.dart';

class BlackoutDrawer extends StatelessWidget {
  const BlackoutDrawer();

  @override
  Widget build(BuildContext context) {
    return BlocListener<DrawerCubit, DrawerState>(
      cubit: sl<DrawerCubit>(),
      listener: (context, state) async {
        if (state is GoToSettings) {
          await Navigator.pushNamed(context, Routes.settings);
          sl<DrawerCubit>().initializeDrawer();
        }
      },
      child: Drawer(
        child: BlocBuilder<DrawerCubit, DrawerState>(
          cubit: sl<DrawerCubit>(),
          builder: (context, state) {
            if (state is LoadedDrawer) {
              return Column(
                children: [
                  Header(
                    username: state.username,
                  ),
                  Expanded(
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: state.homes.length,
                        itemBuilder: (context, index) {
                          var home = state.homes[index];
                          return Card(
                            child: ListTile(
                              title: Text(home.name),
                              leading: state.activeHome == state.homes.indexOf(home) ? Icon(Icons.home) : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: Text(S.of(context).SETTINGS_TITLE),
                      leading: Icon(Icons.settings),
                      onTap: () => sl<DrawerCubit>().tapOnSettings(),
                    ),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
