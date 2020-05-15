import 'package:Blackout/bloc/category/category_bloc.dart';
import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/change_repository.dart';
import 'package:Blackout/data/repository/item_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/data/repository/product_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/item.dart';
import 'package:Blackout/models/listable.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/unit/unit.dart';
import 'package:Blackout/models/user.dart';
import 'package:bloc/bloc.dart' show Bloc;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ModelChangeRepository modelChangeRepository;
  final CategoryRepository categoryRepository;
  final ProductRepository productRepository;
  final BlackoutPreferences blackoutPreferences;
  final CategoryBloc categoryBloc;
  final ProductBloc productBloc;

  HomeBloc(this.blackoutPreferences, this.categoryRepository, this.productRepository, this.categoryBloc, this.modelChangeRepository, this.productBloc);

  @override
  HomeState get initialState => HomeInitialState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LoadAll) {
      yield Loading();
      Home home = await blackoutPreferences.getHome();
      List<Category> categories = await categoryRepository.findAllByHomeId(home.id);
      List<Product> products = await productRepository.findAllByHomeIdAndCategoryIsNull(home.id);
      List<Listable> cards = <Listable>[]
        ..addAll(products)
        ..addAll(categories)
        ..sort((a, b) => a.title.compareTo(b.title));
      yield LoadedAll(cards);
    } else if (event is TapOnCategory) {
      categoryBloc.add(LoadCategory(event.category.id));
    } else if (event is TapOnProduct) {
      productBloc.add(LoadProduct(event.product.id));
    }
  }
}
