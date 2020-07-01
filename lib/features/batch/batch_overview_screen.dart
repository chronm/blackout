import 'package:flutter/material.dart' show BuildContext, Column, Container, GlobalKey, Key, MainAxisSize, Scaffold, ScaffoldState, State, StatefulWidget, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../widget/horizontal_text_divider/horizontal_text_divider.dart';
import '../../widget/scrollable_container/scrollable_container.dart';
import '../blackout_drawer/blackout_drawer.dart';
import 'bloc/batch_bloc.dart';
import 'widgets/batch_dial.dart';
import 'widgets/batch_title.dart';
import 'widgets/changes_list.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({Key key}) : super(key: key);

  @override
  _BatchScreenState createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BatchBloc, BatchState>(
      bloc: sl<BatchBloc>(),
      listener: (context, state) {},
      child: Scaffold(
        key: _scaffold,
        drawer: BlackoutDrawer(),
        body: ScrollableContainer(
          fullscreen: true,
          child: BlocBuilder<BatchBloc, BatchState>(
            bloc: sl<BatchBloc>(),
            builder: (context, state) {
              if (state is ShowBatch) {
                var batch = state.batch;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    BatchTitle(
                      scaffold: _scaffold,
                      batch: batch,
                    ),
                    HorizontalTextDivider(
                      text: S.of(context).CHANGES,
                    ),
                    ChangesList(
                      batch: batch,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
        floatingActionButton: const BatchDial(),
      ),
    );
  }
}
