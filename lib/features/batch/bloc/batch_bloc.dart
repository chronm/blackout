import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/batch_repository.dart';
import '../../../data/repository/change_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/product.dart';
import '../../group/bloc/group_bloc.dart';
import '../../home/bloc/home_bloc.dart';
import '../../product/bloc/product_bloc.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final ChangeRepository changeRepository;
  final BatchRepository batchRepository;
  final BlackoutPreferences blackoutPreferences;

  BatchBloc(this.changeRepository, this.batchRepository, this.blackoutPreferences);

  @override
  BatchState get initialState => InitialBatchState();

  Batch _batch;

  @override
  Stream<BatchState> mapEventToState(BatchEvent event) async* {
    if (event is CreateBatch) {
      _batch = Batch(product: event.product);
      yield ShowBatch(_batch);
    }
    if (event is SaveBatch) {
      var user = await blackoutPreferences.getUser();
      _batch = await batchRepository.save(event.batch, user);
      sl<ProductBloc>().add(LoadProduct(_batch.product.id));
      if (_batch.product.group != null) {
        sl<GroupBloc>().add(LoadGroup(_batch.product.group.id));
      }
      sl<HomeBloc>().add(LoadAll());
      yield ShowBatch(_batch);
    }
    if (event is UseBatch) {
      _batch = event.batch;
      yield ShowBatch(_batch);
    }
    if (event is LoadBatch) {
      _batch = await batchRepository.findOneByBatchId(event.batchId);
      yield ShowBatch(_batch);
    }
  }
}
