import 'package:hive/hive.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/db/ProfileDao.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:collection/collection.dart';

class LocalUserDao extends ProfileDao {
  /*@Query("select * from LocalUser")
  Future<LocalUser?> fetchUser();*/

  Future<void> removeUser() async {
    var u = await getLocalUserDb();
    await u.clear();
  }

  Future<Box<LocalUser>> getLocalUserDb() async {
    return await Hive.openBox<LocalUser>('LocalUser');
  }

  Future<LocalUser?> fetchUser() async {
    var u = await getLocalUserDb();
    return u.values.firstOrNull;
  }

  Future<void> setLocalUser(LocalUser localUser) async {
    var u = await getLocalUserDb();
    await removeUser();
    await removeProfile();
    await u.add(localUser);
    //await removeProfile();
    //await removeUser();
    //return await insertLocalUser(localUser) ?? 0;
  }
}
