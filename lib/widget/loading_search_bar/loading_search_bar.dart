import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef void SearchBarCallback(String search);

class LoadingSearchBar extends StatefulWidget implements PreferredSizeWidget {
  final HomeBloc _bloc = sl<HomeBloc>();
  final SearchBarCallback callback;

  LoadingSearchBar({Key key, @required this.callback}) : super(key: key);

  @override
  _LoadingSearchBarState createState() => _LoadingSearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _LoadingSearchBarState extends State<LoadingSearchBar> {
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

  Widget _title() => Text(
        "Blackout",
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
      title: searching ? _searchingTextField() : _title(),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 5.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: widget._bloc,
          builder: (context, state) {
            if (state is Loading) {
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
