import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart';

class ScrollableMaterialDialog extends StatelessWidget {
  final Widget child;

  ScrollableMaterialDialog({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.0),
      child: Material(
        child: ScrollableContainer(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
