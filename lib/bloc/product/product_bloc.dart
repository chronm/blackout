import 'package:Blackout/data/repository/model_change_repository.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ModelChangeRepository modelChangeRepository;

  ProductBloc(this.modelChangeRepository);

  @override
  ProductState get initialState => ProductInitialState();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProduct) {
      List<ModelChange> changes = await modelChangeRepository.findAllByProductIdAndHomeId(event.product.id, event.product.home.id)
        ..sort((a, b) => a.modificationDate.compareTo(b.modificationDate));
      yield ShowProduct(event.product, changes);
    }
  }
}
