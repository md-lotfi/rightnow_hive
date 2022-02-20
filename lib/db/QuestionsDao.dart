import 'package:hive/hive.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/ChoicesDao.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/allowed_types.dart';
import 'package:rightnow/models/branched_conditions.dart';
import 'package:rightnow/models/branched_links.dart';
import 'package:rightnow/models/choice.dart';
import 'package:rightnow/models/dependent_condition.dart';
import 'package:collection/collection.dart';

class QuestionsDao extends ChoicesDao {
  Future<Box<Question>> getQuestionDb() async {
    return await Hive.openBox<Question>('Question');
  }

  //@Query("select * from Question where fieldSet = :fieldSetId order by id")Tuesday, August 31, 2021 5:07:59 | Tuesday, August 31, 2021 5:09:29
  Future<List<Question>> fetchQuestion(int fieldSetId) async {
    var q = await getQuestionDb();
    var r = q.values.where((element) => element.fieldSet == fieldSetId).sorted((a, b) {
      print("checking questions order ${a.createdAtTimeStamp()}, ${b.createdAtTimeStamp()}, is less ${b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())}");
      return a.createdAtTimeStamp().compareTo(b.createdAtTimeStamp());
    }).toList();
    //var x = r..sort();
    print("questions are list ${r.map((e) => e.label).toList()}");
    return r;
  }

  //@Query("select * from Question where id = :id limit 1")
  Future<Question?> fetchQuestionOne(int id) async {
    var q = await getQuestionDb();
    return q.values.firstWhereOrNull((element) => element.id == id);
  }

  //@Query("delete from Question")
  Future<void> removeAllQuestions() async {
    var q = await getQuestionDb();
    await q.clear();
  }

  //@Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertQuestions(List<Question> questions) async {
    var q = await getQuestionDb();
    for (Question ch in questions) {
      if (q.values.firstWhereOrNull((element) => element.id == ch.id) == null) await q.add(ch);
    }
    //await q.addAll(questions);
  }

  Future<List<Question>> fetchQuestionsWithChoices(int fieldSetId) async {
    List<Question> ql = [];
    List<Question> questions = await fetchQuestion(fieldSetId);

    for (var q in questions) {
      if (q.resourcetype == SELECT_QUESTION) {
        await fetchChoices(q.id!).then((List<Choice> choices) {
          q.choices = choices;
        });
      }
      await fetchDependentCondtion(q.id!).then((List<DependentCondition> dc) {
        q.depandantConditions = dc;
      });
      await fetchBranchedConditions(q.id!).then((List<BranchedConditions> bc) {
        print("received branched conditions are ${bc.map((e) => e.toJson())}"); // + bc.length.toString()
        q.branchedConditions = bc;
      });

      await fetchBranchedLink(q.id!).then((List<BranchedLinks>? bl) {
        q.branchedLinks = bl;
      });
      ql.add(q);
    }

    /*.then((List<Question> questions) async {
      
    });*/
    return ql; //.sorted((a, b) => ((a.createdAtTimeStamp()) < (b.createdAtTimeStamp()) ? 1 : 0)).toList();
  }

  Future<void> setQuestions(List<Question> questions, int fieldId) async {
    List<Question> ql = [];
    List<Choice> cl = [];
    List<DependentCondition> dc = [];
    List<BranchedConditions> bc = [];
    List<BranchedLinks> bl = [];
    List<AllowedTypes> allowedTypes = [];
    for (var q in questions) {
      q.fieldSet = fieldId;
      if (q.choices != null) {
        for (var c in q.choices!) {
          c.questionId = q.id;
          cl.add(c);
        }
      }
      if (q.depandantConditions != null) {
        for (var c in q.depandantConditions!) {
          c.questionId = q.id;
          dc.add(c);
        }
      }
      if (q.branchedConditions != null) {
        for (var c in q.branchedConditions!) {
          print("saving branched conditions from ${q.id.toString()}, ${c.isActive}");
          if (c.isActive == true) {
            c.questionId = q.id;
            bc.add(c);
          }
        }
      }
      if (q.branchedLinks != null) {
        for (var c in q.branchedLinks!) {
          c.questionId = q.id;
          bl.add(c);
        }
      }
      if (q.allowedTypes != null) {
        for (var c in q.allowedTypes!) {
          c.questionId = q.id;
          allowedTypes.add(c);
        }
      }
      ql.add(q);
    }

    print("bc is ${bc.map((e) => e.toJson())}");
    await setChoices(cl);
    await insertDependentConditions(dc);
    await insertBranchedLinks(bl);
    await insertBranchedConditions(bc);
    await insertAllowedTypes(allowedTypes);
    await insertQuestions(ql);
  }
}
