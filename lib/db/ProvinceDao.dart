import 'package:hive/hive.dart';
import 'package:rightnow/models/province.dart';
import 'package:collection/collection.dart';

class ProvinceDao {
  Future<Box<Province>> getProvinceDb() async {
    return await Hive.openBox<Province>('Province');
  }

  //@Query("select * from Province")
  Future<List<Province>> fetchProvinces() async {
    var r = await getProvinceDb();
    return r.values.toList();
  }

  //@Query("select * from Province where id = :id limit 1")
  Future<Province?> fetchProvince(String id) async {
    var r = await getProvinceDb();
    return r.values.firstWhereOrNull((element) => element.id == id);
  }

  Future<void> removeAllProvinces() async {
    var r = await getProvinceDb();
    await r.clear();
  }

  Future<void> insertProvince(Province province) async {
    var r = await getProvinceDb();
    await r.add(province);
  }

  Future<void> setProvince(Province province) async {
    await removeAllProvinces();
    await insertProvince(province);
  }
}
