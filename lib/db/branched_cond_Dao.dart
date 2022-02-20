import 'package:hive/hive.dart';
import 'package:rightnow/db/branched_links_Dao.dart';
import 'package:rightnow/models/branched_conditions.dart';
import 'package:collection/collection.dart';

class BranchedConditionsDao extends BranchedLinksDao {
  Future<Box<BranchedConditions>> getBranchedConditionsDb() async {
    return await Hive.openBox<BranchedConditions>('BranchedConditions');
  }

  //@Query("select * from BranchedConditions where questionId = :questionId")
  Future<List<BranchedConditions>> fetchBranchedConditions(int questionId) async {
    var b = await getBranchedConditionsDb();
    return b.values.where((element) => element.questionId == questionId).toList();
  }

  Future<void> removeAllDC() async {
    var b = await getBranchedConditionsDb();
    await b.clear();
  }

  Future<void> insertBranchedConditions(List<BranchedConditions> tags) async {
    var b = await getBranchedConditionsDb();
    for (BranchedConditions ch in tags) {
      if (ch.isActive == true) if (b.values.firstWhereOrNull((element) => element.id == ch.id) == null) await b.add(ch);
    }
    //await b.addAll(tags);
  }

  /*@Query("delete from BranchedConditions")
  Future<void> removeAllDC();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertBranchedConditions(List<BranchedConditions> tags);*/

  /*@transaction
  Future<List<int>> setChoices(List<Choice> choices, int questionId) async {
    await removeAllChoices(questionId);
    return await insertChoices(choices)
  }*/
}
