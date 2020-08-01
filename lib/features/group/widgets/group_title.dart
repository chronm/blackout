import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../typedefs.dart';
import '../../../widget/model_changes_widget/model_changes_widget.dart';
import '../../../widget/title_card/title_card.dart';
import '../cubit/group_cubit.dart';
import 'group_configuration.dart';

class GroupTitle extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final Group group;
  final StringCallback searchCallback;

  const GroupTitle({
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
            sl<GroupCubit>().saveGroup(group);
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
