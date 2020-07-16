import 'package:moor/moor.dart' show DatabaseAccessor, InsertMode, UseDao;
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/batch.dart';
import '../../models/change.dart';
import '../../models/model_change.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../database/batch_table.dart';
import '../database/database.dart';

part 'batch_repository.g.dart';

@UseDao(tables: [BatchTable])
class BatchRepository extends DatabaseAccessor<Database> with _$BatchRepositoryMixin {
  BatchRepository(Database attachedDatabase) : super(attachedDatabase);

  Future<Batch> createBatch(BatchEntry batchEntry, {bool recurseProduct = true, bool recurseChanges = true}) async {
    Batch batch;

    Product product;
    if (recurseProduct) {
      product = await attachedDatabase.productRepository.findOneByProductId(batchEntry.productId, recurseBatches: false);
    }

    var changes = <Change>[];
    if (recurseChanges) {
      changes = await attachedDatabase.changeRepository.findAllByBatchId(batchEntry.id, recurseBatch: false)
        ..sort((a, b) => a.changeDate.compareTo(b.changeDate));
    }

    var modelChanges = await attachedDatabase.modelChangeRepository.findAllByBatchId(batchEntry.id);

    batch = Batch.fromEntry(batchEntry, product: product, changes: changes, modelChanges: modelChanges);

    if (recurseChanges) {
      for (var change in changes) {
        change.batch = batch;
      }
    }

    if (recurseProduct && batch.product != null) {
      batch.product.batches = [batch];
    }

    return batch;
  }

  Future<Batch> findOneByBatchId(String batchId, {bool recurseProduct = true, bool recurseChanges = true}) async {
    var query = select(batchTable)..where((i) => i.id.equals(batchId));
    var batchEntry = (await query.getSingle());
    if (batchEntry == null) return null;

    return await createBatch(batchEntry, recurseProduct: recurseProduct, recurseChanges: recurseChanges);
  }

  Future<List<Batch>> findAllByProductId(String productId, {bool recurseProduct = true}) async {
    var batches = <Batch>[];

    Product product;
    if (recurseProduct) {
      product = await attachedDatabase.productRepository.findOneByProductId(productId, recurseGroup: false, recurseBatches: false);
    }

    var query = select(batchTable)..where((p) => p.productId.equals(productId));
    var result = await query.get();
    for (var batchEntry in result) {
      var batch = await createBatch(batchEntry, recurseProduct: false, recurseChanges: true);
      batch.product = product;
      batches.add(batch);
    }

    if (recurseProduct) {
      product.batches = batches;
    }

    return batches
      ..sort((a, b) {
        if (a.expirationDate == null && b.expirationDate != null) {
          return -1;
        }
        if (a.expirationDate != null && b.expirationDate == null) {
          return 1;
        }
        return a.creationOrExpirationDate.compareTo(b.creationOrExpirationDate);
      });
  }

  Future<Batch> save(Batch batch, User user) async {
    if (batch.id == null) {
      batch.id = Uuid().v4();
      var change = ModelChange(modificationDate: LocalDate.today(), home: batch.product.home, user: user, modification: ModelChangeType.create, batchId: batch.id);
      await attachedDatabase.modelChangeRepository.save(change);
    } else {
      var change = ModelChange(modificationDate: LocalDate.today(), home: batch.product.home, user: user, modification: ModelChangeType.modify, batchId: batch.id);
      await attachedDatabase.modelChangeRepository.save(change);

      var oldBatch = await findOneByBatchId(batch.id);
      var modifications = oldBatch.getModifications(batch);
      for (var modification in modifications) {
        modification.modelChange = change;
        attachedDatabase.modificationRepository.save(modification);
      }
    }

    await into(batchTable).insert(batch.toCompanion(), mode: InsertMode.replace);

    return await findOneByBatchId(batch.id);
  }

  Future<int> drop(Batch batch, User user) async {
    assert(batch.id != null, "Batch is no database object");

    for (var change in batch.changes) {
      attachedDatabase.changeRepository.drop(change, user);
    }

    var change = ModelChange(user: user, modificationDate: LocalDate.today(), modification: ModelChangeType.delete, home: batch.product.home, batchId: batch.id);
    attachedDatabase.modelChangeRepository.save(change);

    return await (delete(batchTable)..where((i) => i.id.equals(batch.id))).go();
  }
}
