import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/data/sharedpref/shared_preference_cache.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/displayable.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final SharedPreferenceCache sharedPreferenceCache;

  HomeBloc(this.sharedPreferenceCache, this.categoryRepository, this.productRepository);

  @override
  HomeState get initialState => HomeInitialState();

  Future<Product> createProduct(Home home) async {
    User user = await sharedPreferenceCache.getUser();
    Product product = Product(id: Uuid().v4(), description: "Marmorkuchen", home: home, refillLimit: 0.8);
    Item item = Item(id: Uuid().v4(), notificationDate: LocalDateTime.now().subtractMonths(1), product: product, home: home);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 1, item: item);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: -0.5, item: item);
    product.items = [item];
    item.changes = [change, change2];

    return product;
  }

  Future<Category> createCategory(Home home) async {
    User user = await sharedPreferenceCache.getUser();
    Category category = Category(id: Uuid().v4(), name: "Ei", pluralName: "Eier", refillLimit: 6, warnInterval: Period(days: 5), home: home);
    Product product = Product(id: Uuid().v4(), ean: "lalelu", description: "Freilandeier 10 Stück M", category: category, home: home);
    Item item = Item(id: Uuid().v4(), expirationDate: LocalDateTime.now().addMonths(1), product: product, home: home);
    Change change = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: 10, item: item);
    Change change2 = Change(id: Uuid().v4(), user: user, home: home, changeDate: LocalDateTime.now(), value: -5, item: item);
    category.products = [product];
    product.items = [item];
    item.changes = [change, change2];

    return category;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadAll) {
      yield Loading();
      Home home = await sharedPreferenceCache.getHome();
      List<Category> categories = await categoryRepository.findAllByHomeId(home.id);
      List<Product> products = await productRepository.findAllByHomeIdAndCategoryIsNull(home.id);
      categories = [await createCategory(home)];
      products = [await createProduct(home)];
      List<Displayable> cards = [categories[0], products[0]];
      yield LoadedAll(cards..sort((a, b) => a.title.compareTo(b.title)));
    }
  }
}
