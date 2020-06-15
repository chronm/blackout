import 'package:Blackout/widget/search_bar/search_bar.dart';
import 'package:flutter/material.dart';

typedef SearchCallback(String searchString);

class TitleCard extends StatelessWidget {
  final Object tag;
  final String title;
  final String trendingDown;
  final String event;
  final String available;
  final VoidCallback modifyAction;
  final String productName;
  final String groupName;
  final SearchCallback callback;
  final VoidCallback changesAction;
  final GlobalKey<ScaffoldState> scaffold;

  const TitleCard({
    Key key,
    @required this.title,
    @required this.scaffold,
    @required this.modifyAction,
    @required this.available,
    @required this.tag,
    @required this.changesAction,
    this.callback,
    this.trendingDown,
    this.event,
    this.productName,
    this.groupName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).padding.top + 48.0 + 48.0 + 20.0 + (trendingDown != null ? 48.0 : 0) + (event != null ? 48.0 : 0) + (productName != null ? 48.0 : 0) + (groupName != null ? 48.0 : 0);
    return Hero(
      tag: tag,
      child: SearchBar(
        scaffold: scaffold,
        height: height,
        callback: callback,
        child: Container(
          height: height,
          color: Theme.of(context).accentColor,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                        productName != null
                            ? Container(
                                height: 48.0,
                                width: 48.0,
                                child: const Icon(Icons.insert_drive_file),
                              )
                            : null,
                        groupName != null
                            ? Container(
                                height: 48.0,
                                width: 48.0,
                                child: const Icon(Icons.tab),
                              )
                            : null,
                        Container(
                          height: 48.0,
                          width: 48.0,
                          child: const Icon(Icons.shopping_basket),
                        ),
                        trendingDown != null
                            ? Container(
                                height: 48.0,
                                width: 48.0,
                                child: const Icon(Icons.trending_down),
                              )
                            : null,
                        event != null
                            ? Container(
                                height: 48.0,
                                width: 48.0,
                                child: const Icon(Icons.event),
                              )
                            : null,
                      ].where((element) => element != null).toList(),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 48.0,
                          child: Center(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        productName != null
                            ? Container(
                                height: 48.0,
                                child: Center(
                                  child: Text(
                                    productName,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        groupName != null
                            ? Container(
                                height: 48.0,
                                child: Center(
                                  child: Text(
                                    groupName,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        Container(
                          height: 48.0,
                          child: Center(
                            child: Text(
                              available,
                              style: const TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ),
                        trendingDown != null
                            ? Container(
                                height: 48.0,
                                child: Center(
                                  child: Text(
                                    trendingDown,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                        event != null
                            ? Container(
                                height: 48.0,
                                child: Center(
                                  child: Text(
                                    event,
                                    style: const TextStyle(
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ].where((element) => element != null).toList(),
                    ),
                    Spacer(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: IconButton(
                            icon: const Icon(Icons.mode_edit),
                            iconSize: 16.0,
                            onPressed: modifyAction,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: IconButton(
                            icon: const Icon(Icons.history),
                            iconSize: 16.0,
                            onPressed: changesAction,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
