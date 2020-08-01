import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Change;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/batch_repository.dart';
import '../../../data/repository/change_repository.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/home_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../data/secure/secure_storage.dart';
import '../../../di/di.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/change.dart';
import '../../../models/group.dart';
import '../../../models/home.dart';
import '../../../models/home_card.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../models/user.dart';
import '../../blackout_drawer/cubit/drawer_cubit.dart';
import '../../home/cubit/home_cubit.dart';

part 'setup_event.dart';

part 'setup_state.dart';

class SetupCubit extends Cubit<SetupState> {
  final BlackoutPreferences blackoutPreferences;
  final SecureStorage secureStorage;

  SetupCubit(this.blackoutPreferences, this.secureStorage) : super(InitialSetupState());

  void createHomeAndFinish(String homeName, String username, String password) async {
    await prepareApplication(password);
    var home = Home(id: Uuid().v4(), name: homeName);
    home = await sl<HomeRepository>().save(home, active: true);

    var user = User(id: Uuid().v4(), name: username);
    user = await sl<UserRepository>().save(user, active: true);
    await blackoutPreferences.setUser(user);
    await blackoutPreferences.setHome(home);
    await secureStorage.setDatabasePassword(password);
    var cards = <HomeCard>[];
    if (kDebugMode) {
      await createGroup(home);
      await createProduct(home);
      var groups = await sl<GroupRepository>().findAllByHomeId(home.id, usedCached: false);
      var products = await sl<ProductRepository>().findAllByHomeIdAndGroupIsNull(home.id);
      cards
        ..addAll(products)
        ..addAll(groups)
        ..sort((a, b) => a.title.compareTo(b.title));
    }
    sl<HomeCubit>().useCards(cards);
    sl<DrawerCubit>().initializeDrawer();
    sl.unregister<SetupCubit>();
    emit(GoToHome());
  }

  Future<void> createProduct(Home home) async {
    var user = await blackoutPreferences.getUser();
    var product = Product(description: "Marmorkuchen", unit: UnitEnum.weight, home: home, refillLimit: 0.8);
    await sl<ProductRepository>().save(product, user);
    var batch = Batch(product: product);
    await sl<BatchRepository>().save(batch, user);
    var change = Change(user: user, home: batch.product.home, changeDate: LocalDate.today(), value: 1, batch: batch);
    var change2 = Change(user: user, home: batch.product.home, changeDate: LocalDate.today(), value: -0.50505, batch: batch);
    product.batches = [batch];
    batch.changes = [change, change2];

    await sl<ChangeRepository>().save(change);
    await sl<ChangeRepository>().save(change2);
  }

  Future<void> createGroup(Home home) async {
    var user = await blackoutPreferences.getUser();
    var group = Group(name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 8), unit: UnitEnum.unitless, home: home);
    await sl<GroupRepository>().save(group, user);
    group.warnInterval = Period(days: 5);
    await sl<GroupRepository>().save(group, user);
    var product = Product(ean: "lalelu", description: "Freilandeier 10 Stück M", group: group, home: home);
    await sl<ProductRepository>().save(product, user);
    var product2 = Product(ean: "lalelu2", description: "Freilandeier 10 Stück L", group: group, home: home);
    await sl<ProductRepository>().save(product2, user);
    var batch = Batch(expirationDate: LocalDate.today().addDays(1), product: product);
    await sl<BatchRepository>().save(batch, user);
    var batch2 = Batch(expirationDate: LocalDate.today().addDays(20), product: product2);
    await sl<BatchRepository>().save(batch2, user);
    var change = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: 10, batch: batch);
    var change2 = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: -5, batch: batch);
    var change3 = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: 10, batch: batch2);
    group.products = [product, product2];
    product.batches = [batch];
    product2.batches = [batch2];
    batch.changes = [change, change2];
    batch2.changes = [change3];

    await sl<ChangeRepository>().save(change);
    await sl<ChangeRepository>().save(change2);
    await sl<ChangeRepository>().save(change3);
  }
}
