import 'package:flutter/material.dart' show BuildContext, Column, Expanded, Key, Navigator, Scaffold, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../../routes.dart';
import '../../widget/relative_height_container/relative_height_container.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import 'cubit/setup_cubit.dart';
import 'widgets/blackout_header.dart';
import 'widgets/setup_steps.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({
    Key key,
  }) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SetupCubit, SetupState>(
        cubit: sl<SetupCubit>(),
        listener: (context, state) {
          if (state is GoToHome) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
        child: ScrollableContainer(
          fullscreen: true,
          child: Column(
            children: <Widget>[
              RelativeHeightContainer(factor: 0.1),
              BlackoutHeader(),
              Expanded(
                child: SetupSteps(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
