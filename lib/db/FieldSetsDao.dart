import 'package:hive/hive.dart';
import 'package:rightnow/db/QuestionsDao.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:collection/collection.dart';

class FieldSetsDao extends QuestionsDao {
  Future<Box<FieldSet>> getFieldSetDb() async {
    return await Hive.openBox<FieldSet>('FieldSet');
  }

  //@Query("select * from FieldSet where form = :formId")
  Future<List<FieldSet>> fetchFields(int formId) async {
    var f = await getFieldSetDb();
    return f.values.where((element) => element.form == formId).toList();
  }

  //@Query("select * from FieldSet where form = :formId")
  Future<List<FieldSet>> fetchFieldsAll(int formId) async {
    var f = await getFieldSetDb();
    return f.values.where((element) => element.form == formId).toList();
  }

  //@Query("select * from FieldSet where id = :fieldId limit 1")
  Future<FieldSet?> fetchFieldSet(int fieldId) async {
    var f = await getFieldSetDb();
    return f.values.firstWhereOrNull((element) => element.id == fieldId);
  }

  Future<FieldSet?> fetchFieldSetOnlyOne(int formId) async {
    var f = await getFieldSetDb();
    return f.values.firstWhereOrNull((element) => element.form == formId);
  }

  //@Query("delete from FieldSet")
  Future<void> removeAllFieldSets() async {
    var f = await getFieldSetDb();
    await f.clear();
  }

  //@Query("update FieldSet set qAnswered = :qAnswered where id = :id")
  Future<void> setAnsweredCounts(int id, int qAnswered) async {
    var f = await getFieldSetDb();
    FieldSet? r = f.values.firstWhereOrNull((element) => element.id == id);
    if (r != null) {
      r.qAnswered = qAnswered;
      await r.save();
    }
  }

  //@Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFieldSets(List<FieldSet> fieldSet) async {
    var f = await getFieldSetDb();
    for (FieldSet field in fieldSet) {
      if (f.values.firstWhereOrNull((element) => element.id == field.id) == null) await f.add(field);
    }
    //await f.addAll(fieldSet);
  }

  Future<void> setFields(List<FieldSet> fieldSets, int formId) async {
    //await removeAllFieldSets();
    for (var f in fieldSets) {
      if (f.questions != null) await setQuestions(f.questions!, f.id!);
    }
    await insertFieldSets(fieldSets);
  }

  Future<int> getCount(int formId) async {
    List<FieldSet?> f = await fetchFieldsAll(formId);
    int qTotal = 0;
    for (var item in f) {
      qTotal += item?.questionsCount ?? 0;
    }

    return qTotal;
  }

  Future<List<FieldSet>> getFieldSetWithQuestions(int formId) async {
    List<FieldSet>? f = await fetchFields(formId);
    for (var item in f) {
      var q = await fetchQuestion(item.id!);
      item.questions = [];
      for (var qe in q) {
        print("adding question ${qe.label}");
        item.questions!.add(qe);
      }
    }

    return List.from(f);
  }
}
