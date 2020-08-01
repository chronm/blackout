import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/preferences/blackout_preferences.dart';
import '../../../data/repository/batch_repository.dart';
import '../../../data/repository/change_repository.dart';
import '../../../main.dart';
import '../../../models/batch.dart';
import '../../../models/product.dart';
import '../../group/cubit/group_cubit.dart';
import '../../home/cubit/home_cubit.dart';
import '../../product/cubit/product_cubit.dart';

part 'batch_event.dart';

part 'batch_state.dart';

class BatchCubit extends Cubit<BatchState> {
  final ChangeRepository changeRepository;
  final BatchRepository batchRepository;
  final BlackoutPreferences blackoutPreferences;

  BatchCubit(this.changeRepository, this.batchRepository, this.blackoutPreferences) : super(InitialBatchState());

  Batch _batch;

  void createBatch(Product product) {
    _batch = Batch(product: product);
    emit(ShowBatch(_batch));
  }

  void saveBatch(Batch batch) async {
    var user = await blackoutPreferences.getUser();
    _batch = await batchRepository.save(batch, user);
    sl<ProductCubit>().loadProduct(_batch.product.id);
    if (_batch.product.group != null) {
      sl<GroupCubit>().loadGroup(_batch.product.group.id);
    }
    sl<HomeCubit>().loadAll();
    emit(ShowBatch(_batch));
  }

  void useBatch(Batch batch) {
    _batch = batch;
    emit(ShowBatch(_batch));
  }

  void loadBatch(String batchId) async {
    _batch = await batchRepository.findOneByBatchId(batchId);
    emit(ShowBatch(_batch));
  }
}
