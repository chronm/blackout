import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/bloc/product/product_bloc.dart';
import 'package:Blackout/data/preferences/blackout_preferences.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  final ModelChangeRepository modelChangeRepository;
  final BlackoutPreferences blackoutPreferences;
  final ProductBloc productBloc;

  CategoryBloc(this.categoryRepository, this.modelChangeRepository, this.blackoutPreferences, this.productBloc);

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is SaveCategory) {
      User user = await blackoutPreferences.getUser();
      Category category = await categoryRepository.save(event.category, user);
      List<ModelChange> changes = await modelChangeRepository.findAllByCategoryIdAndHomeId(category.id, category.home.id)
        ..sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
      yield ShowCategory(category, changes);
    }
    if (event is LoadCategory) {
      Home home = await blackoutPreferences.getHome();
      Category category = await categoryRepository.getOneByCategoryIdAndHomeId(event.categoryId, home.id);
      List<ModelChange> changes = await modelChangeRepository.findAllByCategoryIdAndHomeId(event.categoryId, home.id)
        ..sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
      yield ShowCategory(category, changes);
    }
    if (event is TapOnProduct) {
      productBloc.add(LoadProduct(event.product.id));
    }
  }
}
