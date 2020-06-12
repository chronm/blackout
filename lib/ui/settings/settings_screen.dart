import 'package:Blackout/bloc/settings/settings_bloc.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
import 'package:Blackout/widget/username_field/username_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings {
  User user;

  Settings(this.user);

  Settings clone() {
    return Settings(user.clone());
  }

  @override
  bool operator ==(other) {
    return user == other.user;
  }
}

class SettingsScreen extends StatefulWidget {
  final SettingsBloc bloc = sl<SettingsBloc>();

  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings _settings;
  Settings _oldSettings;
  bool _errorInUsername = false;

  @override
  void initState() {
    super.initState();
    widget.bloc.first.then((state) {
      if (state is LoadedSettings) {
        _settings = Settings(state.user.clone());
        _oldSettings = Settings(state.user.clone());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(S.of(context).SETTINGS_TITLE),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _settings != _oldSettings && !_errorInUsername ? () => widget.bloc.add(SaveSettings(_settings, context)) : null,
          )
        ],
      ),
      body: ScrollableContainer(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: BlocBuilder<SettingsBloc, SettingsState>(
            bloc: widget.bloc,
            builder: (context, state) {
              if (state is LoadedSettings) {
                return Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: UsernameField(
                          initialValue: state.user.name,
                          callback: (value, error) {
                            setState(() {
                              _settings.user.name = value;
                              _errorInUsername = error;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
