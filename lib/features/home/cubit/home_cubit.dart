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
import '../../group/cubit/group_cubit.dart';
import '../../product/cubit/product_cubit.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;

  HomeCubit(this.blackoutPreferences, this.groupRepository, this.productRepository) : super(HomeInitialState());

  var _cards = <HomeCard>[];

  void _checkForUpdates() async {
    var remoteVersion = await sl<GithubClient>().getVersion();
    var currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    if (currentVersion < remoteVersion) {
      emit(AskForUpdate());
    }
  }

  void _maybeShowChangelog() async {
    var currentVersion = Version.parse((await PackageInfo.fromPlatform()).version);
    Version latestVersion;
    try {
      latestVersion = Version.parse(await blackoutPreferences.getVersion());
      // ignore: avoid_catching_errors
    } on ArgumentError {
      latestVersion = Version.none;
    }
    if (latestVersion != Version.none && latestVersion < currentVersion) {
      emit(ShowChangelog());
      await blackoutPreferences.setVersion(currentVersion.toString());
    }
  }

  void routineCheck() {
    _checkForUpdates();
    _maybeShowChangelog();
  }

  void doUpdate() async {
    var url = await sl<GithubClient>().getDownloadUrl();
    sl<GithubClient>().downloadApk(url).then(OpenFile.open);
  }

  void tapOnGroup(Group group) {
    sl<GroupCubit>().useGroup(group);
    emit(GoToGroup());
  }

  void tapOnProduct(Product product) {
    sl<ProductCubit>().useProduct(product);
    emit(GoToProduct());
  }

  void loadAll() async {
    emit(Loading());
    var home = await blackoutPreferences.getHome();
    var groups = await groupRepository.findAllByHomeId(home.id, usedCached: false);
    var products = await productRepository.findAllByHomeIdAndGroupIsNull(home.id);
    var cards = <HomeCard>[]
      ..addAll(products)
      ..addAll(groups)
      ..sort((a, b) => a.title.compareTo(b.title));
    _cards = cards;
  }

  void useCards(List<HomeCard> cards) {
    _cards = cards;
    emit(LoadedAll(_cards));
  }

  void redraw() {
    emit(LoadedAll(_cards));
  }
}
