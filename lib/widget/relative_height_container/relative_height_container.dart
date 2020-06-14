import 'package:flutter/material.dart' show BuildContext, Container, Key, MediaQuery, StatelessWidget, Widget, required;

class RelativeHeightContainer extends StatelessWidget {
  final double factor;

  const RelativeHeightContainer({
    Key key,
    @required this.factor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * factor,
    );
  }
}
