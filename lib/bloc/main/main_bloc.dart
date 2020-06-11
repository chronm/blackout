import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final BlackoutPreferences _blackoutPreferences;
  final HomeBloc _homeBloc;

  MainBloc(this._blackoutPreferences, this._homeBloc);

  @override
  MainState get initialState => InitialMainState();

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    if (event is InitializeAppEvent) {
      User user = await _blackoutPreferences.getUser();
      Home home = await _blackoutPreferences.getHome();
      if (user == null || home == null) {
        yield GoToSetup();
      } else {
        _homeBloc.add(LoadAll());
        yield GoToHome();
        Version currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
        Version latestVersion;
        try {
          latestVersion = Version.parse(await _blackoutPreferences.getVersion());
        } on ArgumentError {
          latestVersion = Version.none;
        }
        if (latestVersion != Version.none && latestVersion < currentVersion) {
          yield ShowChangelog();
        }
        await _blackoutPreferences.setVersion(currentVersion.toString());
      }
    }
  }
}
