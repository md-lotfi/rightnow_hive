import 'package:hive/hive.dart';
import 'package:rightnow/db/ReclamationsDao.dart';
import 'package:rightnow/models/hash.dart';
import 'package:collection/collection.dart';

class HashDao extends ReclamationsDao {
  Future<Box<Hashes>> getHashDb() async {
    return await Hive.openBox<Hashes>('Hashes');
  }

  //@Query("select * from Hashes where type = :type limit 1")
  Future<Hashes?> fetchHashesByType(String type) async {
    var h = await getHashDb();
    return h.values.firstWhereOrNull((element) => element.type == type);
  }

  //@Query("select * from Hashes where hash = :hash limit 1")
  Future<Hashes?> fetchHash(String hash) async {
    var h = await getHashDb();
    return h.values.firstWhereOrNull((element) => element.hash == hash);
  }

  Future<void> removeHashEverything() async {
    var h = await getHashDb();
    await h.clear();
  }

  //@Query("delete from Hashes where type = :type")
  Future<void> removeAll(String type) async {
    var h = await getHashDb();
    Hashes? r = h.values.firstWhereOrNull((element) => element.type == type);
    if (r != null) {
      r.delete();
    }
  }

  Future<void> insertHash(Hashes hash) async {
    var h = await getHashDb();
    await h.add(hash);
  }

  Future<void> setHash(Hashes hash) async {
    await removeAll(hash.type!);
    await insertHash(hash);
  }
}
