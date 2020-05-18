import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef SearchCallback = void Function(String search);
typedef TitleResolver<S> = String Function(S state);
typedef SubtitleResolver<S> = String Function(S state);
typedef TitleCallback<S> = void Function(S state);

class LoadingAppBar<B extends Bloc<dynamic, S>, S> extends StatefulWidget implements PreferredSizeWidget {
  final B bloc;
  final SearchCallback searchCallback;
  final String title;
  final SubtitleResolver<S> subtitleResolver;
  final TitleResolver<S> titleResolver;
  final TitleCallback<S> titleCallback;

  LoadingAppBar({
    Key key,
    @required this.bloc,
    this.searchCallback,
    this.title,
    this.titleResolver,
    this.titleCallback,
    this.subtitleResolver,
  })  : assert((title != null && titleResolver == null) || (title == null && titleResolver != null)),
        super(key: key);

  @override
  _LoadingAppBarState createState() => _LoadingAppBarState<B, S>();

  @override
  Size get preferredSize => Size.fromHeight(61.0);
}

class _LoadingAppBarState<B extends Bloc<dynamic, S>, S> extends State<LoadingAppBar<B, S>> {
  TextEditingController _controller = TextEditingController();
  bool _searching = false;

  Widget _searchingTextField() => TextField(
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        controller: _controller,
        onChanged: widget.searchCallback,
      );

  Widget _title(S state) {
    bool loading;
    if (state is LoadingState) {
      loading = true;
    } else {
      loading = false;
    }

    return InkWell(
      onTap: () => widget.titleCallback(state),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: FLAppBarTitle(
                title: widget.title ?? widget.titleResolver(state),
                titleStyle: TextStyle(
                  fontSize: 20,
                ),
                subtitle: widget.subtitleResolver != null ? widget.subtitleResolver(state) : null,
                subtitleStyle: TextStyle(
                  fontSize: 15,
                ),
                layout: FLAppBarTitleLayout.vertical,
                showLoading: loading,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchButton() => IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          setState(() {
            _searching = true;
          });
        },
      );

  Widget _clearButton() => IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          _controller.text = "";
          widget.searchCallback("");
        },
      );

  Widget _backButton() => Center(
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _searching = false;
            });
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _searching && widget.searchCallback != null ? _backButton() : null,
      title: BlocBuilder<B, S>(
        bloc: widget.bloc,
        builder: (context, state) {
          return _searching && widget.searchCallback != null ? _searchingTextField() : _title(state);
        },
      ),
      centerTitle: true,
      actions: widget.searchCallback != null
          ? <Widget>[
              _searching ? _clearButton() : _searchButton(),
            ]
          : null,
    );
  }
}
