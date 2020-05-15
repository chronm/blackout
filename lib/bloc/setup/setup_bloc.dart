import 'package:Blackout/bloc/home/home_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/home_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/repository/user_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'setup_event.dart';
part 'setup_state.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  final BlackoutPreferences _blackoutPreferences;
  final HomeBloc _homeBloc;
  final HomeRepository homeRepository;
  final UserRepository userRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final ItemRepository itemRepository;
  final ChangeRepository changeRepository;

  SetupBloc(this._blackoutPreferences, this._homeBloc, this.homeRepository, this.userRepository, this.categoryRepository, this.productRepository, this.itemRepository, this.changeRepository);

  @override
  SetupState get initialState => InitialSetupState();

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is SetupAndCreateEvent) {
      Home home = Home(id: Uuid().v4(), name: event.home);
      home = await homeRepository.save(home);

      User user = User(id: Uuid().v4(), name: event.username);
      user = await userRepository.save(user);
      await _blackoutPreferences.setUser(user);
      await _blackoutPreferences.setHome(home);
      await createCategory(home);
      await createProduct(home);
      _homeBloc.add(LoadAll());
      yield GoToHome();
    }
    if (event is SetupAndJoinEvent) {
      throw UnimplementedError();
    }
  }


  Future<void> createProduct(Home home) async {
    User user = await _blackoutPreferences.getUser();
    Product product = Product(description: "Marmorkuchen", unit: UnitEnum.weight, home: home, refillLimit: 0.8);
    await productRepository.save(product, user);
    Item item = Item(id: Uuid().v4(), notificationDate: LocalDateTime.now().subtractMonths(1), product: product, home: home);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 1, item: item);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: -0.50505, item: item);
    product.items = [item];
    item.changes = [change, change2];

    await itemRepository.save(item);
    await changeRepository.save(change);
    await changeRepository.save(change2);
  }

  Future<void> createCategory(Home home) async {
    User user = await _blackoutPreferences.getUser();
    Category category = Category(name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 8), unit: UnitEnum.unitless, home: home);
    await categoryRepository.save(category, user);
    category.warnInterval = Period(days: 5);
    await categoryRepository.save(category, user);
    Product product = Product(ean: "lalelu", description: "Freilandeier 10 Stück M", category: category, home: home);
    await productRepository.save(product, user);
    Product product2 = Product(ean: "lalelu2", description: "Freilandeier 10 Stück L", category: category, home: home);
    await productRepository.save(product2, user);
    Item item = Item(id: Uuid().v4(), expirationDate: LocalDateTime.now().addDays(1), product: product, home: home);
    Item item2 = Item(id: Uuid().v4(), expirationDate: LocalDateTime.now().addDays(20), product: product2, home: home);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 10, item: item);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: -5, item: item);
    Change change3 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 10, item: item2);
    category.products = [product, product2];
    product.items = [item];
    product2.items = [item2];
    item.changes = [change, change2];
    item2.changes = [change3];

    await itemRepository.save(item);
    await itemRepository.save(item2);
    await changeRepository.save(change);
    await changeRepository.save(change2);
    await changeRepository.save(change3);
  }
}
