import 'package:Blackout/features/setup/widgets/blackout_header.dart';
import 'package:Blackout/features/setup/widgets/create_home.dart';
import 'package:Blackout/features/setup/widgets/setup_home.dart';
import 'package:Blackout/features/setup/widgets/setup_user.dart';
import 'package:Blackout/features/setup/widgets/welcome_widget.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/features/setup/bloc/setup_bloc.dart';
import 'package:Blackout/widget/relative_height_container/relative_height_container.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart' show BuildContext, Colors, Column, Flexible, FocusNode, Key, Navigator, Scaffold, State, StatefulWidget, Theme, Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({
    Key key,
  }) : super(key: key);

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

enum SetupHomeAction { create, join }

class _SetupScreenState extends State<SetupScreen> {
  String username = "";
  String homeName = "";
  FocusNode _userFocus = FocusNode();
  SetupHomeAction _action;
  int _pageCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SetupBloc, SetupState>(
        bloc: sl<SetupBloc>(),
        listener: (context, state) {
          if (state is GoToHome) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
        child: ScrollableContainer(
          fullscreen: true,
          child: Column(
            children: <Widget>[
              RelativeHeightContainer(factor: 0.1),
              BlackoutHeader(),
              RelativeHeightContainer(factor: 0.1),
              Flexible(
                child: Swiper(
                  itemCount: _pageCount,
                  loop: false,
                  pagination:  SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      size: 5.0,
                      activeColor: Theme.of(context).accentColor,
                      color: Colors.white30,
                    ),
                  ),
                  control: SwiperControl(
                    disableColor: Colors.white30,
                    color: Theme.of(context).accentColor,
                  ),
                  onIndexChanged: (index) {
                    if (index == 2) {
                      _userFocus.unfocus();
                    }
                  },
                  itemBuilder: (context, index) {
                    List<Widget> body = <Widget>[];
                    switch (index) {
                      case 0:
                        return const WelcomeWidget();
                      case 1:
                        return SetupUser(
                          focus: _userFocus,
                          callback: (value) {
                            if (value == '') {
                              setState(() {
                                _pageCount = 2;
                                username = value;
                              });
                            } else {
                              setState(() {
                                _pageCount = 3;
                                username = value;
                              });
                            }
                          },
                        );
                        break;
                      case 2:
                        return SetupHome(
                          callback: (action) {
                            setState(() {
                              _action = action;
                              _pageCount = 4;
                            });
                          },
                        );
                      case 3:
                        if (_action == SetupHomeAction.create) {
                          return CreateHome(
                            callback: (value) {
                              setState(() {
                                homeName = value;
                              });
                            },
                            finishAction: () => sl<SetupBloc>().add(CreateHomeAndFinish(username, homeName)),
                          );
                        } else if (_action == SetupHomeAction.join) {}
                        break;
                    }

                    return Column(
                      children: body,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
