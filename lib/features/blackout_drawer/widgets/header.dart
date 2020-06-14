import 'package:Blackout/features/blackout_drawer/bloc/drawer_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String username;

  const Header({
    Key key,
    @required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
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
                icon: const Icon(Icons.settings),
                iconSize: 20.0,
                padding: EdgeInsets.zero,
                onPressed: () => sl<DrawerBloc>().add(TapOnSettings()),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: const Text(
                  "Blackout",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white30,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    const Icon(Icons.person),
                    const VerticalDivider(),
                    Text(
                      username,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
