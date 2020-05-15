import 'package:flutter/material.dart' show AlwaysScrollableScrollPhysics, BuildContext, Container, Key, MediaQuery, SingleChildScrollView, StatelessWidget, Widget;

class ScrollableContainer extends StatelessWidget {
  final Widget child;
  final bool fullscreen;

  ScrollableContainer({Key key, this.child, this.fullscreen = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        height: fullscreen ? MediaQuery.of(context).size.height : null,
        width: fullscreen ? MediaQuery.of(context).size.width : null,
        child: child,
      ),
    );
  }
}
