import 'package:Blackout/widget/relative_height_container/relative_height_container.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatelessWidget {
  final String description;
  final double padding;
  final Widget child;

  SetupPage({
    Key key,
    @required this.description,
    @required this.child,
    this.padding = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ),
        RelativeHeightContainer(factor: 0.05),
        Padding(
          padding: EdgeInsets.only(left: padding, right: padding),
          child: child,
        ),
      ],
    );
  }
}
