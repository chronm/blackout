import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void SearchBarCallback(String search);
typedef String TitleResolver(dynamic state);

class LoadingSearchBar<B extends Bloc<dynamic, S>, S> extends StatefulWidget implements PreferredSizeWidget {
  final B bloc;
  final SearchBarCallback callback;
  final String title;
  final TitleResolver titleResolver;
  final VoidCallback titleCallback;

  LoadingSearchBar({
    Key key,
    @required this.callback,
    @required this.bloc,
    this.title,
    this.titleResolver,
    this.titleCallback,
  }) : super(key: key);

  @override
  _LoadingSearchBarState createState() => _LoadingSearchBarState<B, S>();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _LoadingSearchBarState<B extends Bloc<dynamic, S>, S> extends State<LoadingSearchBar> {
  TextEditingController _controller = TextEditingController();
  bool searching = false;

  Widget _searchingTextField() => TextField(
        autofocus: true,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        controller: _controller,
        onChanged: widget.callback,
      );

  Widget _title(S state) => InkWell(
        onTap: widget.titleCallback,
        child: SizedBox(
          height: 56,
          child: Center(
            child: Text(
              widget.title ?? widget.titleResolver(state),
            ),
          ),
        ),
      );

  Widget _searchButton() => IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          setState(() {
            searching = true;
          });
        },
      );

  Widget _clearButton() => IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          _controller.text = "";
          widget.callback("");
        },
      );

  Widget _backButton() => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          setState(() {
            searching = false;
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: searching ? _backButton() : null,
      title: BlocBuilder<B, S>(
        bloc: widget.bloc,
        builder: (context, state) {
          return searching ? _searchingTextField() : _title(state);
        },
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 5.0),
        child: BlocBuilder<B, S>(
          bloc: widget.bloc,
          builder: (context, state) {
            if (state is LoadingState) {
              return LinearProgressIndicator();
            }
            if (state is LoadedAll) {
              return Container();
            }
            return Container();
          },
        ),
      ),
      actions: <Widget>[
        searching ? _clearButton() : _searchButton(),
      ],
    );
  }
}
