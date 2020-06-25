import 'package:flutter/material.dart' show AlwaysScrollableScrollPhysics, BuildContext, Container, Key, MediaQuery, SingleChildScrollView, StatelessWidget, Widget, required;

class ScrollableContainer extends StatelessWidget {
  final Widget child;
  final bool fullscreen;

  const ScrollableContainer({
    Key key,
    @required this.child,
    this.fullscreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: fullscreen ? MediaQuery.of(context).size.height : null,
        width: fullscreen ? MediaQuery.of(context).size.width : null,
        child: child,
      ),
    );
  }
}
