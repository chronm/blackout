import 'package:Blackout/features/group_overview/bloc/group_bloc.dart';
import 'package:Blackout/features/group_overview/widgets/group_configuration.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/typedefs.dart';
import 'package:Blackout/widget/model_changes_widget/model_changes_widget.dart';
import 'package:Blackout/widget/title_card/title_card.dart';
import 'package:flutter/material.dart';

class GroupTitle extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final Group group;
  final StringCallback searchCallback;

  GroupTitle({
    Key key,
    @required this.group,
    @required this.scaffold,
    this.searchCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleCard(
      scaffold: scaffold,
      title: group.title,
      tag: group.id,
      trendingDown: group.tooFewAvailable ? S.of(context).GENERAL_LESS_THAN_AVAILABLE(group.scientificRefillLimit) : null,
      available: S.of(context).GENERAL_AMOUNT_AVAILABLE(group.scientificAmount),
      event: group.buildStatus(context),
      modifyAction: () => showDialog(
        context: context,
        builder: (context) => GroupConfiguration(
          group: group,
          action: (group) {
            Navigator.pop(context);
            sl<GroupBloc>().add(SaveGroup(group));
          },
        ),
      ),
      changesAction: () => showDialog(
        context: context,
        builder: (context) => ModelChangesWidget(changes: group.modelChanges),
      ),
      callback: searchCallback,
    );
  }
}
