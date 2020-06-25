import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

import '../../models/change.dart';
import '../../models/charge.dart';
import '../../models/model_change.dart';
import '../../models/product.dart';
import '../../models/user.dart';
import '../database/charge_table.dart';
import '../database/database.dart';

part 'charge_repository.g.dart';

@UseDao(tables: [ChargeTable])
class ChargeRepository extends DatabaseAccessor<Database> with _$ChargeRepositoryMixin {
  ChargeRepository(Database db) : super(db);

  Future<Charge> createCharge(ChargeEntry chargeEntry, {bool recurseProduct = true, bool recurseChanges = true}) async {
    Charge charge;

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.findOneByProductId(chargeEntry.productId, recurseCharges: false);
    }

    var changes = <Change>[];
    if (recurseChanges) {
      changes = await db.changeRepository.findAllByChargeId(chargeEntry.id, recurseCharge: false)
        ..sort((a, b) => a.changeDate.compareTo(b.changeDate));
    }

    var modelChanges = await db.modelChangeRepository.findAllByChargeId(chargeEntry.id);

    charge = Charge.fromEntry(chargeEntry, product: product, changes: changes, modelChanges: modelChanges);

    if (recurseChanges) {
      for (var change in changes) {
        change.charge = charge;
      }
    }

    if (recurseProduct && charge.product != null) {
      charge.product.charges = [charge];
    }

    return charge;
  }

  Future<Charge> findOneByChargeId(String chargeId, {bool recurseProduct = true, bool recurseChanges = true}) async {
    var query = select(chargeTable)..where((i) => i.id.equals(chargeId));
    var chargeEntry = (await query.getSingle());
    if (chargeEntry == null) return null;

    return await createCharge(chargeEntry, recurseProduct: recurseProduct, recurseChanges: recurseChanges);
  }

  Future<List<Charge>> findAllByProductId(String productId, {bool recurseProduct = true}) async {
    var charges = <Charge>[];

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.findOneByProductId(productId, recurseGroup: false, recurseCharges: false);
    }

    var query = select(chargeTable)..where((p) => p.productId.equals(productId));
    var result = await query.get();
    for (var chargeEntry in result) {
      var charge = await createCharge(chargeEntry, recurseProduct: false, recurseChanges: true);
      charge.product = product;
      charges.add(charge);
    }

    if (recurseProduct) {
      product.charges = charges;
    }

    return charges;
  }

  Future<Charge> save(Charge charge, User user) async {
    if (charge.id == null) {
      charge.id = Uuid().v4();
      var change = ModelChange(modificationDate: LocalDate.today(), home: charge.product.home, user: user, modification: ModelChangeType.create, chargeId: charge.id);
      await db.modelChangeRepository.save(change);
    } else {
      var change = ModelChange(modificationDate: LocalDate.today(), home: charge.product.home, user: user, modification: ModelChangeType.modify, chargeId: charge.id);
      await db.modelChangeRepository.save(change);

      var oldCharge = await findOneByChargeId(charge.id);
      var modifications = oldCharge.getModifications(charge);
      for (var modification in modifications) {
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(chargeTable).insert(charge.toCompanion(), mode: InsertMode.replace);

    return await findOneByChargeId(charge.id);
  }

  Future<int> drop(Charge charge, User user) async {
    assert(charge.id != null, "Charge is no database object");

    for (var change in charge.changes) {
      db.changeRepository.drop(change, user);
    }

    var change = ModelChange(user: user, modificationDate: LocalDate.today(), modification: ModelChangeType.delete, home: charge.product.home, chargeId: charge.id);
    db.modelChangeRepository.save(change);

    return await (delete(chargeTable)..where((i) => i.id.equals(charge.id))).go();
  }
}
