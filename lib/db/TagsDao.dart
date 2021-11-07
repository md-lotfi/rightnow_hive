import 'package:hive/hive.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/models/tag.dart';

class TagsDao extends HashDao {
  Future<Box<Tag>> getTagDb() async {
    return await Hive.openBox<Tag>('Tag');
  }

  //@Query("select * from Tag")
  Future<List<Tag>> fetchTags() async {
    var r = await getTagDb();
    return r.values.toList();
  }

  Future<void> removeAllTags() async {
    var r = await getTagDb();
    await r.clear();
  }

  Future<void> insertTags(List<Tag> tags) async {
    var r = await getTagDb();
    await r.addAll(tags);
  }
}
