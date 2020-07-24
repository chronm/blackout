import 'package:bloc/bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info/package_info.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../../data/api/github/github_client.dart';
import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../main.dart';
import '../../../models/group.dart';
import '../../../models/home_card.dart';
import '../../../models/product.dart';
import '../../group/bloc/group_bloc.dart';
import '../../product/bloc/product_bloc.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  HomeBloc(this.blackoutPreferences, this.groupRepository, this.productRepository);

  @override
  HomeState get initialState => HomeInitialState();

  var _cards = <HomeCard>[];

  Stream<HomeState> checkForUpdates() async* {
    var remoteVersion = await sl<GithubClient>().getVersion();
    var currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    if (currentVersion < remoteVersion) {
      yield AskForUpdate();
    }
  }

  Stream<HomeState> maybeShowChangelog() async* {
    var currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    Version latestVersion;
    try {
      latestVersion = Version.parse(await blackoutPreferences.getVersion());
      // ignore: avoid_catching_errors
    } on ArgumentError {
      latestVersion = Version.none;
    }
    if (latestVersion != Version.none && latestVersion < currentVersion) {
      yield ShowChangelog();
      await blackoutPreferences.setVersion(currentVersion.toString());
    }
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is RoutineCheck) {
      yield* checkForUpdates();
      yield* maybeShowChangelog();
    }
    if (event is DoUpdate) {
      var url = await sl<GithubClient>().getDownloadUrl();
      var filename = await sl<GithubClient>().downloadApk(url);
      OpenFile.open(filename);
    }
    if (event is TapOnGroup) {
      sl<GroupBloc>().add(UseGroup(event.group));
      yield GoToGroup();
    }
    if (event is TapOnProduct) {
      sl<ProductBloc>().add(UseProduct(event.product));
      yield GoToProduct();
    }
    if (event is LoadAll) {
      yield Loading();
      var home = await blackoutPreferences.getHome();
      var groups = await groupRepository.findAllByHomeId(home.id, usedCached: false);
      var products = await productRepository.findAllByHomeIdAndGroupIsNull(home.id);
      var cards = <HomeCard>[]
        ..addAll(products)
        ..addAll(groups)
        ..sort((a, b) => a.title.compareTo(b.title));
      _cards = cards;
    }
    if (event is UseCards) {
      _cards = event.cards;
      yield LoadedAll(_cards);
    }
    if (event is Redraw) {
      yield LoadedAll(_cards);
    }
  }
}
