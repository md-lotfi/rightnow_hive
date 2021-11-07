import 'package:hive/hive.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/models/allowed_types.dart';
import 'package:collection/collection.dart';

class AllowedTypesDao extends HashDao {
  Future<Box<AllowedTypes>> getAllowedTypesDb() async {
    return await Hive.openBox<AllowedTypes>('AllowedTypes');
  }

  //@Query("select * from AllowedTypes where questionId = :questionId")
  Future<List<AllowedTypes>> fetchAllowedTypes(int questionId) async {
    var a = await getAllowedTypesDb();
    return a.values.toList();
  }

  Future<void> removeAllAllowedTypes() async {
    var a = await getAllowedTypesDb();
    await a.clear();
  }

  Future<void> insertAllowedTypes(List<AllowedTypes> allowedTypes) async {
    var a = await getAllowedTypesDb();
    for (AllowedTypes ch in allowedTypes) {
      if (a.values.firstWhereOrNull((element) => element.id == ch.id) == null) await a.add(ch);
    }
    //await a.addAll(allowedTypes);
  }
}
