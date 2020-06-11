import 'package:Blackout/bloc/setup/setup_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/routes.dart';
import 'package:Blackout/widget/blackout_header/blackout_header.dart';
import 'package:Blackout/widget/qr_view_widget/qr_view_widget.dart';
import 'package:Blackout/widget/relative_height_container/relative_height_container.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:flutter/material.dart'
    show Align, Alignment, BuildContext, Colors, Column, Container, EdgeInsets, Expanded, FlatButton, Flexible, FocusNode, InputDecoration, Navigator, Padding, Radio, Row, Scaffold, SizedBox, State, StatefulWidget, Text, TextAlign, TextEditingController, TextField, TextStyle, Widget;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SetupScreen extends StatefulWidget {
  final SetupBloc _bloc = sl<SetupBloc>();

  @override
  _SetupScreenState createState() => _SetupScreenState();
}

enum SetupHomeAction { create, join }

class _SetupScreenState extends State<SetupScreen> {
  TextEditingController _userController = TextEditingController();
  FocusNode _userFocus = FocusNode();
  TextEditingController _homeController = TextEditingController();
  FocusNode _homeFocus = FocusNode();
  SetupHomeAction _action;
  int pageCount = 2;
  String qr;

  List<Widget> _buildWelcomeWidget() {
    return <Widget>[
      Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Text(
          S.of(context).SETUP_WELCOME_CARD_TITLE,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            height: 1.5,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSetupUserWidget() {
    return _buildPage(
      S.of(context).SETUP_USERNAME_CARD_TITLE,
      TextField(
        focusNode: _userFocus,
        decoration: InputDecoration(
          labelText: S.of(context).SETUP_USERNAME,
        ),
        controller: _userController,
        onChanged: (value) {
          if (value == '') {
            setState(() {
              pageCount = 2;
            });
          } else {
            setState(() {
              pageCount = 3;
            });
          }
        },
      ),
    );
  }

  List<Widget> _buildSetupHomeWidget() {
    return _buildPage(
      S.of(context).SETUP_HOME_CARD_TITLE,
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Radio<SetupHomeAction>(
                value: SetupHomeAction.create,
                groupValue: _action,
                onChanged: (value) {
                  setState(() {
                    _action = value;
                    pageCount = 4;
                  });
                },
              ),
              Text(S.of(context).SETUP_CREATE_HOME),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Column(
            children: <Widget>[
              Radio<SetupHomeAction>(
                value: SetupHomeAction.join,
                groupValue: _action,
//                onChanged: (value) {
//                  setState(() {
//                    _action = value;
//                    pageCount = 4;
//                  });
//                },
              ),
              Text(S.of(context).SETUP_JOIN_HOME),
            ],
          ),
        ],
      ),
      padding: 100,
    );
  }

  List<Widget> _buildNewHomePage() {
    return _buildPage(
      S.of(context).SETUP_CREATE_HOME_CARD_TITLE,
      Column(
        children: <Widget>[
          TextField(
            focusNode: _homeFocus,
            decoration: InputDecoration(
              labelText: S.of(context).SETUP_CREATE_HOME,
            ),
            controller: _homeController,
          ),
          RelativeHeightContainer(factor: 0.01),
          FlatButton(
            color: Colors.redAccent,
            onPressed: () {
              _homeFocus.unfocus();
              widget._bloc.add(CreateHomeAndFinish(_userController.text, _homeController.text));
            },
            child: Text(S.of(context).SETUP_FINISH),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildJoinHomePage() {
    return _buildPage(
      S.of(context).SETUP_JOIN_HOME_CARD_TITLE,
      SizedBox(
        height: 200,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 5,
                child: QRViewWidget(
                  callback: (value) => widget._bloc.add(JoinHomeAndFinish(_userController.text, value)),
                )),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPage(String description, Widget child, {double padding = 50}) => <Widget>[
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
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SetupBloc, SetupState>(
        bloc: widget._bloc,
        listener: (context, state) {
          if (state is GoToHome) {
            Navigator.pushReplacement(context, RouteBuilder.build(Routes.HomeRoute));
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
                  itemBuilder: (context, index) {
                    List<Widget> body = <Widget>[];
                    switch (index) {
                      case 0:
                        body = _buildWelcomeWidget();
                        break;
                      case 1:
                        body = _buildSetupUserWidget();
                        break;
                      case 2:
                        body = _buildSetupHomeWidget();
                        break;
                      case 3:
                        if (_action == SetupHomeAction.create) {
                          body = _buildNewHomePage();
                        } else if (_action == SetupHomeAction.join) {
                          body = _buildJoinHomePage();
                        }
                        break;
                    }

                    return Column(
                      children: body,
                    );
                  },
                  itemCount: pageCount,
                  pagination: SwiperPagination(
                    builder: const DotSwiperPaginationBuilder(
                      size: 5.0,
                      activeColor: Colors.redAccent,
                      color: Colors.white30,
                    ),
                  ),
                  control: SwiperControl(
                    disableColor: Colors.white30,
                    color: Colors.redAccent,
                  ),
                  loop: false,
                  onIndexChanged: (index) {
                    if (index == 2) {
                      _userFocus.unfocus();
                    }
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
