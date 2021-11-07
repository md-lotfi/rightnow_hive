import 'package:hive/hive.dart';
import 'package:rightnow/db/allowed_types_Dao.dart';
import 'package:rightnow/models/branched_links.dart';
import 'package:collection/collection.dart';

class BranchedLinksDao extends AllowedTypesDao {
  Future<Box<BranchedLinks>> getBranchedLinksDb() async {
    return await Hive.openBox<BranchedLinks>('BranchedLinks');
  }

  //@Query("select * from BranchedLinks where questionId = :questionId")
  Future<List<BranchedLinks>?> fetchBranchedLink(int questionId) async {
    var b = await getBranchedLinksDb();
    return b.values.where((element) => element.questionId == questionId).toList();
  }

  Future<void> removeAllBranchedLinks() async {
    var b = await getBranchedLinksDb();
    await b.clear();
  }

  Future<void> insertBranchedLinks(List<BranchedLinks> tags) async {
    var b = await getBranchedLinksDb();
    for (BranchedLinks ch in tags) {
      if (b.values.firstWhereOrNull((element) => element.id == ch.id) == null) await b.add(ch);
    }
    //await b.addAll(tags);
  }
}
