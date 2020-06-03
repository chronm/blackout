import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/group_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/charge_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/group.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final BlackoutPreferences _blackoutPreferences;
  final HomeBloc _homeBloc;
  final HomeRepository homeRepository;
  final UserRepository userRepository;
  final GroupRepository groupRepository;
  final ProductRepository productRepository;
  final ChargeRepository chargeRepository;
  final ChangeRepository changeRepository;

  SetupBloc(this._blackoutPreferences, this._homeBloc, this.homeRepository, this.userRepository, this.groupRepository, this.productRepository, this.chargeRepository, this.changeRepository);

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is CreateHomeAndFinish) {
      Home home = Home(id: Uuid().v4(), name: event.home);
      home = await homeRepository.save(home);

      User user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user);
      await _blackoutPreferences.setUser(user);
      await _blackoutPreferences.setHome(home);
      await createGroup(home);
      await createProduct(home);
      _homeBloc.add(LoadAll());
      yield GoToHome();
    }
    if (event is JoinHomeAndFinish) {
      throw UnimplementedError();
    }
  }


  Future<void> createProduct(Home home) async {
    User user = await _blackoutPreferences.getUser();
    Product product = Product(description: "Marmorkuchen", unit: UnitEnum.weight, home: home, refillLimit: 0.8);
    await productRepository.save(product, user);
    Charge charge = Charge(product: product, home: home);
    await chargeRepository.save(charge, user);
    Change change = Change(user: user, home: home, changeDate: LocalDate.today(), value: 1, charge: charge);
    Change change2 = Change(user: user, home: home, changeDate: LocalDate.today(), value: -0.50505, charge: charge);
    product.charges = [charge];
    charge.changes = [change, change2];

    await changeRepository.save(change);
    await changeRepository.save(change2);
  }

  Future<void> createGroup(Home home) async {
    User user = await _blackoutPreferences.getUser();
    Group group = Group(name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 8), unit: UnitEnum.unitless, home: home);
    await groupRepository.save(group, user);
    group.warnInterval = Period(days: 5);
    await groupRepository.save(group, user);
    Product product = Product(ean: "lalelu", description: "Freilandeier 10 Stück M", group: group, home: home);
    await productRepository.save(product, user);
    Product product2 = Product(ean: "lalelu2", description: "Freilandeier 10 Stück L", group: group, home: home);
    await productRepository.save(product2, user);
    Charge charge = Charge(expirationDate: LocalDate.today().addDays(1), product: product, home: home);
    await chargeRepository.save(charge, user);
    Charge charge2 = Charge(expirationDate: LocalDate.today().addDays(20), product: product2, home: home);
    await chargeRepository.save(charge2, user);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDate.today(), value: 10, charge: charge);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDate.today(), value: -5, charge: charge);
    Change change3 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDate.today(), value: 10, charge: charge2);
    group.products = [product, product2];
    product.charges = [charge];
    product2.charges = [charge2];
    charge.changes = [change, change2];
    charge2.changes = [change3];

    await changeRepository.save(change);
    await changeRepository.save(change2);
    await changeRepository.save(change3);
  }
}
