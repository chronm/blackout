import 'package:Blackout/bloc/main/main_bloc.dart';
import 'package:Blackout/data/repository/category_repository.dart';
import 'package:Blackout/data/repository/database_changelog_repository.dart';
import 'package:Blackout/models/category.dart';
import 'package:Blackout/models/database_changelog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  final DatabaseChangelogRepository databaseChangelogRepository;

  CategoryBloc(this.categoryRepository, this.databaseChangelogRepository);

  @override
  CategoryState get initialState => InitialCategoryState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is SaveCategory) {
      Category category = await categoryRepository.save(event.category);
      List<DatabaseChangelog> changes = (await databaseChangelogRepository
          .findAllByCategoryIdAndHomeId(category.id, category.home.id))
        ..sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
      yield ShowCategory(category, changes);
    }
    if (event is LoadCategory) {
      List<DatabaseChangelog> changes = await databaseChangelogRepository
          .findAllByCategoryIdAndHomeId(
              event.category.id, event.category.home.id)
        ..sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
      yield ShowCategory(event.category, changes);
    }
  }
}
