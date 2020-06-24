import 'package:flutter/material.dart';

import '../scrollable_container/scrollable_container.dart';

class ScrollableMaterialDialog extends StatelessWidget {
  final Widget child;

  const ScrollableMaterialDialog({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0),
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
