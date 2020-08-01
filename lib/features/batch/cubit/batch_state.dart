part of 'batch_cubit.dart';

abstract class BatchState {}

class InitialBatchState extends BatchState {}

class ShowBatch extends BatchState {
  final Batch batch;

  ShowBatch(this.batch);
}
