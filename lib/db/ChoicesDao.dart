import 'package:hive/hive.dart';
import 'package:rightnow/db/dependent_cond_Dao.dart';
import 'package:rightnow/models/choice.dart';
import 'package:collection/collection.dart';

class ChoicesDao extends DependentConditionsDao {
  Future<Box<Choice>> getChoiceDb() async {
    return await Hive.openBox<Choice>('Choice');
  }

  //@Query("select * from Choice where questionId = :questionId")
  Future<List<Choice>> fetchChoices(int questionId) async {
    var b = await getChoiceDb();
    return b.values.where((element) => element.questionId == questionId).toList();
  }

  Future<void> removeAllChoices() async {
    var b = await getChoiceDb();
    await b.clear();
  }

  Future<void> insertChoices(List<Choice> choice) async {
    var b = await getChoiceDb();
    for (Choice ch in choice) {
      if (b.values.firstWhereOrNull((element) => element.id == ch.id) == null) await b.add(ch);
    }
    //await b.addAll(choice);
  }

  Future<void> setChoices(List<Choice> choices) async {
    await insertChoices(choices);
  }
}
