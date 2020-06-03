import 'package:flutter/material.dart';

typedef void SearchCallback(String searchString);

class SearchBar extends StatefulWidget {
  final Widget child;
  final SearchCallback callback;
  final double height;

  SearchBar({Key key, this.callback, this.child, this.height}) : super(key: key);

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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(1.0), border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0), color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.8),
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: "Search",
                            labelStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: TextStyle(
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
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _controller.text = "";
                              _focusNode.unfocus();
                              setState(() {
                                _searching = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _focusNode.requestFocus();
                              setState(() {
                                _searching = true;
                              });
                            },
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
