import 'package:hive/hive.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:collection/collection.dart';

class MultiSelectAnswersDao extends FormFieldsDao {
  Future<Box<MultiSelectAnswer>> getMultiSelectAnswerDb() async {
    return await Hive.openBox<MultiSelectAnswer>('MultiSelectAnswer');
  }

  //@Query("select * from MultiSelectAnswer where answerId = :answerId")
  Future<List<MultiSelectAnswer>?> fetchMultiSelectAnswers(int answerId) async {
    var r = await getMultiSelectAnswerDb();
    return r.values.where((element) => element.answerId == answerId).toList();
  }

  //@Query("delete from MultiSelectAnswer where answerHolderId = :answerHolderId")
  Future<void> removeAllMultiSelectAnswers(int answerHolderId) async {
    var r = await getMultiSelectAnswerDb();
    final Map<dynamic, MultiSelectAnswer> answers = r.toMap();

    answers.forEach((key, value) async {
      print("deleting anwer multianswer key check $key, $answerHolderId, ${value.answerHolderId}");
      if (value.answerHolderId == answerHolderId) {
        print("deleting anwer multianswer key $key");
        await r.delete(key);
      }
    });
    //await r.clear();
  }

  Future<void> insertMultiSelectAnswer(MultiSelectAnswer answer) async {
    var r = await getMultiSelectAnswerDb();
    await r.add(answer);
  }

  Future<void> insertMultiSelectAnswers(List<MultiSelectAnswer> answers) async {
    var r = await getMultiSelectAnswerDb();
    /*for (MultiSelectAnswer ch in answers) {
      if (r.values.firstWhereOrNull((element) => element. == ch.id) == null) await r.add(ch);
    }*/
    print("multi select answers count ${r.values.length}");
    for (MultiSelectAnswer item in answers) {
      final exists = r.containsKey(item.key);
      if (!exists) {
        await r.add(item);
      }
      await item.save();
    }
  }
}
