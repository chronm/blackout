import 'package:Blackout/data/database/charge_table.dart';
import 'package:Blackout/data/database/database.dart';
import 'package:Blackout/models/change.dart';
import 'package:Blackout/models/charge.dart';
import 'package:Blackout/models/home.dart';
import 'package:Blackout/models/model_change.dart';
import 'package:Blackout/models/modification.dart';
import 'package:Blackout/models/product.dart';
import 'package:Blackout/models/user.dart';
import 'package:moor/moor.dart';
import 'package:time_machine/time_machine.dart';
import 'package:uuid/uuid.dart';

part 'charge_repository.g.dart';

@UseDao(tables: [ChargeTable])
class ChargeRepository extends DatabaseAccessor<Database> with _$ChargeRepositoryMixin {
  ChargeRepository(Database db) : super(db);

  Future<Charge> createCharge(ChargeEntry chargeEntry, {bool recurseProduct = true, bool recurseChanges = true}) async {
    Charge charge;

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.findOneByProductIdAndHomeId(chargeEntry.productId, chargeEntry.homeId, recurseCharges: false);
    }

    List<Change> changes = [];
    if (recurseChanges) {
      changes = await db.changeRepository.findAllByChargeIdAndHomeId(chargeEntry.id, chargeEntry.homeId, recurseCharge: false)
        ..sort((a, b) => a.changeDate.compareTo(b.changeDate));
    }

    Home home = await db.homeRepository.findHomeById(chargeEntry.homeId);

    List<ModelChange> modelChanges = await db.modelChangeRepository.findAllByChargeIdAndHomeId(chargeEntry.id, home.id);

    charge = Charge.fromEntry(chargeEntry, home, product: product, changes: changes, modelChanges: modelChanges);

    if (recurseChanges) {
      charge.changes.forEach((c) => c.charge = charge);
    }

    if (recurseProduct && charge.product != null) {
      charge.product.charges = [charge];
    }

    return charge;
  }

  Future<List<Charge>> findAllByHomeId(String homeId, {bool recurseChanges = true}) async {
    List<ChargeEntry> entries = await (select(chargeTable)..where((i) => i.homeId.equals(homeId))).get();

    List<Charge> charges = [];
    for (ChargeEntry entry in entries) {
      charges.add(await createCharge(entry, recurseChanges: recurseChanges));
    }

    return charges;
  }

  Future<Charge> findOneByChargeIdAndHomeId(String chargeId, String homeId, {bool recurseProduct = true, bool recurseChanges = true}) async {
    var query = select(chargeTable)..where((i) => i.id.equals(chargeId))..where((i) => i.homeId.equals(homeId));
    ChargeEntry chargeEntry = (await query.getSingle());
    if (chargeEntry == null) return null;

    return await createCharge(chargeEntry, recurseProduct: recurseProduct, recurseChanges: recurseChanges);
  }

  Future<List<Charge>> findAllByProductIdAndHomeId(String productId, String homeId, {bool recurseProduct = true}) async {
    List<Charge> charges = [];

    Product product;
    if (recurseProduct) {
      product = await db.productRepository.findOneByProductIdAndHomeId(productId, homeId, recurseGroup: false, recurseCharges: false);
    }

    var query = select(chargeTable)..where((p) => p.productId.equals(productId));
    var result = await query.get();
    for (ChargeEntry chargeEntry in result) {
      Charge charge = await createCharge(chargeEntry, recurseProduct: false, recurseChanges: true);
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
      ModelChange change = ModelChange(modificationDate: LocalDate.today(), home: charge.home, user: user, modification: ModelChangeType.create, chargeId: charge.id);
      await db.modelChangeRepository.save(change);
    } else {
      ModelChange change = ModelChange(modificationDate: LocalDate.today(), home: charge.home, user: user, modification: ModelChangeType.modify, chargeId: charge.id);
      await db.modelChangeRepository.save(change);

      Charge oldCharge = await findOneByChargeIdAndHomeId(charge.id, charge.home.id);
      List<Modification> modifications = oldCharge.getModifications(charge);
      for (Modification modification in modifications) {
        modification.home = charge.home;
        modification.modelChange = change;
        db.modificationRepository.save(modification);
      }
    }

    await into(chargeTable).insertOnConflictUpdate(charge.toCompanion());

    return await findOneByChargeIdAndHomeId(charge.id, charge.home.id);
  }

  Future<int> drop(Charge charge) async {
    assert(charge.id != null, "Charge is no database object");

    charge.changes.forEach((c) => db.changeRepository.drop(c));

    return await (delete(chargeTable)..where((i) => i.id.equals(charge.id))).go();
  }
}
