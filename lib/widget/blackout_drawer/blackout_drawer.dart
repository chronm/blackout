import 'package:Blackout/bloc/drawer/drawer_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlackoutDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: IconButton(
                      icon: Icon(Icons.settings),
                      iconSize: 20.0,
                      padding: EdgeInsets.zero,
                      onPressed: () => sl<DrawerBloc>().add(TapOnSettings(context)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Blackout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white30,
                        ),
                      ),
                    ),
                    Spacer(),
                    BlocBuilder<DrawerBloc, DrawerState>(
                      bloc: sl<DrawerBloc>(),
                      builder: (context, state) {
                        if (state is LoadedDrawer) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                VerticalDivider(),
                                Text(
                                  state.username,
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocBuilder<DrawerBloc, DrawerState>(
                        bloc: sl<DrawerBloc>(),
                        builder: (context, state) {
                          if (state is LoadedDrawer) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Icon(Icons.home),
                                  VerticalDivider(),
                                  Text(
                                    state.homeName,
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
