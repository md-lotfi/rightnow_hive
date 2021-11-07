import 'package:hive/hive.dart';
import 'package:rightnow/db/branched_cond_Dao.dart';
import 'package:rightnow/models/dependent_condition.dart';
import 'package:collection/collection.dart';

class DependentConditionsDao extends BranchedConditionsDao {
  Future<Box<DependentCondition>> getDependentConditionDb() async {
    return await Hive.openBox<DependentCondition>('DependentCondition');
  }

  Future<List<DependentCondition>> fetchDependentCondtion(int questionId) async {
    var b = await getDependentConditionDb();
    return b.values.where((element) => element.questionId == questionId).toList();
  }

  Future<void> removeAllDependentConditions() async {
    var b = await getDependentConditionDb();
    await b.clear();
  }

  Future<void> insertDependentConditions(List<DependentCondition> tags) async {
    var b = await getDependentConditionDb();
    for (DependentCondition ch in tags) {
      if (b.values.firstWhereOrNull((element) => element.id == ch.id) == null) await b.add(ch);
    }
    //await b.addAll(tags);
  }

  /*@Query("select * from DependentCondition where questionId = :questionId")
  Future<List<DependentCondition>> fetchDependentCondtion(int questionId);

  @Query("delete from DependentCondition")
  Future<void> removeAllDependentConditions();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertDependentConditions(List<DependentCondition> dependents);*/

  /*@transaction
  Future<List<int>> setChoices(List<Choice> choices, int questionId) async {
    await removeAllChoices(questionId);
    return await insertChoices(choices)
  }*/
}
