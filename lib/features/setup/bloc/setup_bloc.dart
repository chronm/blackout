import 'package:bloc/bloc.dart' show Bloc;
import 'package:flutter/foundation.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/batch_repository.dart';
import '../../../data/repository/change_repository.dart';
import '../../../data/repository/group_repository.dart';
import '../../../data/repository/home_repository.dart';
import '../../../data/repository/product_repository.dart';
import '../../../data/repository/user_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/change.dart';
import '../../../models/group.dart';
import '../../../models/home.dart';
import '../../../models/product.dart';
import '../../../models/unit/unit.dart';
import '../../../models/user.dart';
import '../../blackout_drawer/bloc/drawer_bloc.dart';
import '../../home/bloc/home_bloc.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final BlackoutPreferences blackoutPreferences;
  final HomeBloc homeBloc;
  final DrawerBloc drawerBloc;
  final HomeRepository homeRepository;
  final UserRepository userRepository;
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final BatchRepository batchRepository;
  final ChangeRepository changeRepository;

  SetupBloc(this.blackoutPreferences, this.homeBloc, this.homeRepository, this.userRepository, this.groupRepository, this.productRepository, this.batchRepository, this.changeRepository, this.drawerBloc);

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is CreateHomeAndFinish) {
      var home = Home(id: Uuid().v4(), name: event.home);
      home = await homeRepository.save(home, active: true);

      var user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user, active: true);
      await blackoutPreferences.setUser(user);
      await blackoutPreferences.setHome(home);
      if (kDebugMode) {
        await createGroup(home);
        await createProduct(home);
      }
      homeBloc.add(LoadAll());
      drawerBloc.add(InitializeDrawer());
      sl.unregister<SetupBloc>();
      yield GoToHome();
    }
    if (event is JoinHomeAndFinish) {
      throw UnimplementedError();
    }
  }

  Future<void> createProduct(Home home) async {
    var user = await blackoutPreferences.getUser();
    var product = Product(description: "Marmorkuchen", unit: UnitEnum.weight, home: home, refillLimit: 0.8);
    await productRepository.save(product, user);
    var batch = Batch(product: product);
    await batchRepository.save(batch, user);
    var change = Change(user: user, home: batch.product.home, changeDate: LocalDate.today(), value: 1, batch: batch);
    var change2 = Change(user: user, home: batch.product.home, changeDate: LocalDate.today(), value: -0.50505, batch: batch);
    product.batches = [batch];
    batch.changes = [change, change2];

    await changeRepository.save(change);
    await changeRepository.save(change2);
  }

  Future<void> createGroup(Home home) async {
    var user = await blackoutPreferences.getUser();
    var group = Group(name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 8), unit: UnitEnum.unitless, home: home);
    await groupRepository.save(group, user);
    group.warnInterval = Period(days: 5);
    await groupRepository.save(group, user);
    var product = Product(ean: "lalelu", description: "Freilandeier 10 Stück M", group: group, home: home);
    await productRepository.save(product, user);
    var product2 = Product(ean: "lalelu2", description: "Freilandeier 10 Stück L", group: group, home: home);
    await productRepository.save(product2, user);
    var batch = Batch(expirationDate: LocalDate.today().addDays(1), product: product);
    await batchRepository.save(batch, user);
    var batch2 = Batch(expirationDate: LocalDate.today().addDays(20), product: product2);
    await batchRepository.save(batch2, user);
    var change = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: 10, batch: batch);
    var change2 = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: -5, batch: batch);
    var change3 = Change(id: Uuid().v4(), home: batch.product.home, user: user, changeDate: LocalDate.today(), value: 10, batch: batch2);
    group.products = [product, product2];
    product.batches = [batch];
    product2.batches = [batch2];
    batch.changes = [change, change2];
    batch2.changes = [change3];

    await changeRepository.save(change);
    await changeRepository.save(change2);
    await changeRepository.save(change3);
  }
}
