import 'package:hive/hive.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/db/ProvinceDao.dart';
import 'package:rightnow/models/profile.dart';
import 'package:collection/collection.dart';

class ProfileDao extends ProvinceDao {
  Future<Profile?> fetchUserProfile() async {
    var p = await getProfileDb();
    Profile? pr = getFirstOrNull(p.values);
    if (pr != null) {
      var prov = await getProvinceDb();
      pr.province = prov.values.firstOrNull;
    }
    return pr;
  }

  Future<void> removeProfile() async {
    var p = await getProfileDb();
    await p.clear();
  }

  Future<Box<Profile>> getProfileDb() async {
    return await Hive.openBox<Profile>('Profile');
  }

  Future<void> setProfile(Profile profile) async {
    //await removeProfile();
    var p = await getProfileDb();
    await removeProfile();
    await p.add(profile);
    var pr = await getProvinceDb();
    await removeAllProvinces();
    if (profile.province != null) await pr.add(profile.province!);
  }
}
