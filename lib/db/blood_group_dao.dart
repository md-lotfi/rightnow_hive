import 'package:hive/hive.dart';
import 'package:rightnow/models/blood_group.dart';

class BloodGroupDao {
  Future<Box<BloodGroup>> getBloodGroupDb() async {
    return await Hive.openBox<BloodGroup>('BloodGroup');
  }

  Future<void> removeAllBloodGroup() async {
    var r = await getBloodGroupDb();
    await r.clear();
  }

  //@Query("select * from BloodGroup")
  Future<List<BloodGroup>> fetchBloodGroup() async {
    var r = await getBloodGroupDb();
    return r.values.toList();
  }

  Future<void> insertBloodGroup(List<BloodGroup> bloodGroups) async {
    var r = await getBloodGroupDb();
    await r.addAll(bloodGroups);
  }

  Future<void> setBloodGroup(List<BloodGroup> bloodGroup) async {
    await removeAllBloodGroup();
    await insertBloodGroup(bloodGroup);
  }
}
