import 'package:flutter/material.dart';

class TooltipIcon extends StatelessWidget {
  final FocusNode focusNode;
  final String title;
  final String tooltip;

  const TooltipIcon({
    Key key,
    @required this.focusNode,
    @required this.tooltip,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 20.0,
      icon: Icon(Icons.info_outline),
      highlightColor: Colors.white,
      color: Colors.white,
      onPressed: () async {
        focusNode.unfocus();
        focusNode.canRequestFocus = false;

        await showDialog(
          context: context,
          child: AlertDialog(
            title: Text(title),
            content: Text(tooltip),
          ),
        );

        Future.delayed(Duration(milliseconds: 100), () {
          focusNode.canRequestFocus = true;
        });
      },
    );
  }
}
