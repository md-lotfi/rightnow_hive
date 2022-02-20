import 'package:hive/hive.dart';
import 'package:rightnow/models/organisation.dart';
import 'package:collection/collection.dart';

class OrganisationDao {
  Future<Box<Organisation>> getOrganisationDb() async {
    return await Hive.openBox<Organisation>('Organisation');
  }

  Future<Organisation?> fetchOrganisation() async {
    var r = await getOrganisationDb();
    return r.values.firstOrNull;
  }

  Future<void> removeAllOrganisations() async {
    var r = await getOrganisationDb();
    await r.clear();
  }

  Future<void> insertOrganisation(Organisation organisation) async {
    var r = await getOrganisationDb();
    await r.add(organisation);
  }

  Future<void> setOrganisation(Organisation Organisation) async {
    await removeAllOrganisations();
    await insertOrganisation(Organisation);
  }
}
