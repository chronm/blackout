import 'package:Blackout/features/settings/widgets/username_field.dart';
import 'package:Blackout/generated/l10n.dart';
import 'package:Blackout/main.dart';
import 'package:Blackout/models/user.dart';
import 'package:Blackout/features/settings/bloc/settings_bloc.dart';
import 'package:Blackout/widget/scrollable_container/scrollable_container.dart';
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
  const SettingsScreen({Key key}) : super(key: key);

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
    sl<SettingsBloc>().first.then((state) {
      if (state is LoadedSettings) {
        setState(() {
          _settings = Settings(state.user.clone());
          _oldSettings = Settings(state.user.clone());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      bloc: sl<SettingsBloc>(),
      listener: (context, state) {
        if (state is GoBack) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(S.of(context).SETTINGS_TITLE),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _settings != _oldSettings && !_errorInUsername ? () => sl<SettingsBloc>().add(SaveSettings(_settings)) : null,
            )
          ],
        ),
        body: ScrollableContainer(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            bloc: sl<SettingsBloc>(),
            builder: (context, state) {
              if (state is LoadedSettings) {
                return Column(
                  children: [
                    UsernameField(
                      initialValue: state.user.name,
                      callback: (value, error) {
                        setState(() {
                          _settings.user.name = value;
                          _errorInUsername = error;
                        });
                      },
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
