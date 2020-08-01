part of 'batch_cubit.dart';

abstract class BatchEvent {}

class CreateBatch extends BatchEvent {
  final Product product;

  CreateBatch(this.product);
}

class UseBatch extends BatchEvent {
  final Batch batch;

  UseBatch(this.batch);
}

class LoadBatch extends BatchEvent {
  final String batchId;

  LoadBatch(this.batchId);
}

class SaveBatch extends BatchEvent {
  final Batch batch;

  SaveBatch(this.batch);
}
