import 'package:hive/hive.dart';
import 'package:rightnow/models/disease.dart';
import 'package:collection/collection.dart';

class DiseaseDao {
  Future<Box<Disease>> getDiseaseDb() async {
    return await Hive.openBox<Disease>('Disease');
  }

  Future<void> removeAllDisease() async {
    var r = await getDiseaseDb();
    await r.clear();
  }

  //@Query("select * from Disease order by name")
  Future<List<Disease>> fetchDisease() async {
    var r = await getDiseaseDb();
    return r.values.sorted((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
  }

  Future<void> insertDisease(List<Disease> decisionResponse) async {
    var r = await getDiseaseDb();
    await r.addAll(decisionResponse);
  }

  Future<void> setDiseases(List<Disease> disease) async {
    await removeAllDisease();
    await insertDisease(disease);
  }
}
