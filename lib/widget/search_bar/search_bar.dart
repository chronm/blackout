import 'package:Blackout/generated/l10n.dart';
import 'package:flutter/material.dart';

typedef void SearchCallback(String searchString);

class SearchBar extends StatefulWidget {
  final Widget child;
  final SearchCallback callback;
  final double height;
  final GlobalKey<ScaffoldState> scaffold;

  const SearchBar({
    Key key,
    @required this.callback,
    @required this.child,
    @required this.height,
    @required this.scaffold,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;
  bool _searching = false;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        widget.callback(_controller.text.toLowerCase());
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height + 40.0,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          widget.child,
          Positioned(
            bottom: -0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0), border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0), color: Colors.white),
                child: Row(
                  children: [
                    widget.scaffold != null
                        ? IconButton(
                            icon:  Icon(
                              Icons.menu,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () => widget.scaffold.currentState.openDrawer(),
                          )
                        : null,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          enabled: widget.callback != null,
                          focusNode: _focusNode,
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: S.of(context).GENERAL_SEARCH,
                            labelStyle: TextStyle(
                              color: widget.callback != null ? Colors.black : Colors.grey,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          onTap: () {
                            setState(() {
                              _searching = true;
                            });
                          },
                        ),
                      ),
                    ),
                    _searching
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: widget.callback != null ? Theme.of(context).accentColor : Colors.grey,
                            ),
                            onPressed: widget.callback != null
                                ? () {
                                    _controller.text = "";
                                    _focusNode.unfocus();
                                    setState(() {
                                      _searching = false;
                                    });
                                  }
                                : null,
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.search,
                              color: widget.callback != null ? Theme.of(context).accentColor : Colors.grey,
                            ),
                            onPressed: widget.callback != null
                                ? () {
                                    _focusNode.requestFocus();
                                    setState(() {
                                      _searching = true;
                                    });
                                  }
                                : null,
                          ),
                  ].where((element) => element != null).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
