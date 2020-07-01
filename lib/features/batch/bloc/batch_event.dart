part of 'batch_bloc.dart';

abstract class BatchEvent {}

class CreateBatch extends BatchEvent {
  final Product product;

  CreateBatch(this.product);
}

class LoadBatch extends BatchEvent {
  final String batchId;

  LoadBatch(this.batchId);
}

class SaveBatch extends BatchEvent {
  final Batch batch;

  SaveBatch(this.batch);
}
