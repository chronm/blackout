import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/database_changelog_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseChangelogRepository databaseChangelogRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final ItemRepository itemRepository;
  final ChangeRepository changeRepository;
  final SharedPreferenceCache sharedPreferenceCache;
  final CategoryBloc categoryBloc;

  HomeBloc(this.sharedPreferenceCache, this.categoryRepository, this.productRepository, this.categoryBloc, this.itemRepository, this.changeRepository, this.databaseChangelogRepository);

  @override
  HomeState get initialState => HomeInitialState();

  Future<void> createProduct(Home home) async {
    User user = await sharedPreferenceCache.getUser();
    Product product = Product(id: Uuid().v4(), description: "Marmorkuchen", unit: baseUnitFromUnit(Unit.weight), home: home, refillLimit: 0.8);
    Item item = Item(id: Uuid().v4(), notificationDate: LocalDateTime.now().subtractMonths(1), product: product, home: home);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 1, item: item);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: -0.50505, item: item);
    product.items = [item];
    item.changes = [change, change2];

    await productRepository.save(product);
    await itemRepository.save(item);
    await changeRepository.save(change);
    await changeRepository.save(change2);
  }

  Future<void> createCategory(Home home) async {
    User user = await sharedPreferenceCache.getUser();
    Category category = Category(id: Uuid().v4(), name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 5), unit: baseUnitFromUnit(Unit.unitless), home: home);
    DatabaseChangelog dbChange = DatabaseChangelog(home: home, user: user, modificationDate: LocalDateTime.now(), categoryId: category.id, modification: ChangelogModification.create);
    DatabaseChangelog dbChange2 = DatabaseChangelog(home: home, user: user, modificationDate: LocalDateTime.now(), categoryId: category.id, fieldName: "warnInterval", from: "P8D", to: "P5D", modification: ChangelogModification.modify);
    Product product = Product(id: Uuid().v4(), ean: "lalelu", description: "Freilandeier 10 Stück M", category: category, home: home);
    Product product2 = Product(id: Uuid().v4(), ean: "lalelu2", description: "Freilandeier 10 Stück L", category: category, home: home);
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

    await categoryRepository.save(category);
    await productRepository.save(product);
    await productRepository.save(product2);
    await itemRepository.save(item);
    await itemRepository.save(item2);
    await changeRepository.save(change);
    await changeRepository.save(change2);
    await changeRepository.save(change3);
    await databaseChangelogRepository.save(dbChange);
    await databaseChangelogRepository.save(dbChange2);
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadAll) {
      yield Loading();
      Home home = await sharedPreferenceCache.getHome();
      await createCategory(home);
      await createProduct(home);
      List<Category> categories = await categoryRepository.findAllByHomeId(home.id);
      List<Product> products = await productRepository.findAllByHomeIdAndCategoryIsNull(home.id);
      List<Displayable> cards = <Displayable>[];
      cards.addAll(products);
      cards.addAll(categories);
      yield LoadedAll(cards..sort((a, b) => a.title.compareTo(b.title)));
    } else if (event is TapOnCategory) {
      categoryBloc.add(LoadCategory(event.category));
    }
  }
}
