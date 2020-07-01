import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/batch_repository.dart';
import '../../../data/repository/change_repository.dart';
import '../../../models/batch.dart';
import '../../../models/product.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchBloc extends Bloc<BatchEvent, BatchState> {
  final ChangeRepository changeRepository;
  final BatchRepository batchRepository;
  final BlackoutPreferences blackoutPreferences;

  BatchBloc(this.changeRepository, this.batchRepository, this.blackoutPreferences);

  @override
  BatchState get initialState => InitialBatchState();

  @override
  Stream<BatchState> mapEventToState(BatchEvent event) async* {
    if (event is CreateBatch) {
      var batch = Batch(product: event.product);
      yield ShowBatch(batch);
    }
    if (event is SaveBatch) {
      var user = await blackoutPreferences.getUser();
      var batch = await batchRepository.save(event.batch, user);
      yield ShowBatch(batch);
    }
    if (event is LoadBatch) {
      var batch = await batchRepository.findOneByBatchId(event.batchId);
      yield ShowBatch(batch);
    }
  }
}
