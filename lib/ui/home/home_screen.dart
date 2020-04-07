import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/widget/loading_search_bar/loading_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final HomeBloc _bloc = sl<HomeBloc>();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: LoadingSearchBar(
          searchController: _searchController,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: widget._bloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadedAll) {
              return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(state.cards[index].title),
                      subtitle: Text("${state.cards[index].amount}"),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
