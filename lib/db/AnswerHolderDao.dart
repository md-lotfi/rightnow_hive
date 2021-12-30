import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:rightnow/db/AnswerDao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:collection/collection.dart';

const HOLDER_NOT_COMPLETED = 0;
const HOLDER_COMPLETED = 1;
const HOLDER_ANY_COMPLETED = 2;

class AnswerHolderDao extends AnswersDao {
  Future<Box<AnswerHolder>> getAnswerHolderDb() async {
    return await Hive.openBox<AnswerHolder>('AnswerHolder');
  }

  //@Query("select * from AnswerHolder where formId = :formId order by id DESC") //completedAt
  Future<List<AnswerHolder>?> fetchAnswerHolder(int formId) async {
    var r = await getAnswerHolderDb();
    //return r.values.where((element) => element.formId == formId).sorted((a, b) => a.id!.compareTo(b.id!));
    return r.values.where((element) => element.formId == formId).sorted((a, b) => b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())).toList();
  }

  //@Query("select * from AnswerHolder where uploaded = 0 order by id DESC") //completedAt
  Future<List<AnswerHolder>?> fetchAnswerHoldersNotUploaded() async {
    var r = await getAnswerHolderDb();
    //return r.values.where((element) => element.uploaded == false).sorted((a, b) => a.id!.compareTo(b.id!));
    return r.values.where((element) => element.uploaded == false).sorted((a, b) => b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())).toList();
  }

  //@Query("select * from AnswerHolder where uploaded = 1 order by id DESC") //completedAt
  Future<List<AnswerHolder>?> fetchAnswerHoldersUploaded() async {
    var r = await getAnswerHolderDb();
    //return r.values.where((element) => element.uploaded == true).sorted((a, b) => a.id!.compareTo(b.id!));
    return r.values.where((element) => element.uploaded == true).sorted((a, b) => b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())).toList();
  }

  //@Query("select * from AnswerHolder where formId = :formId and uploaded = 0 limit 1")
  Future<AnswerHolder?> fetchAnswerHolderOne(int formId, int completed) async {
    var r = await getAnswerHolderDb();
    for (var item in r.values) {
      if (item.formId == formId && (item.uploaded == false) && (((item.completed ?? false) ? 1 : 0) == completed || completed == HOLDER_ANY_COMPLETED)) {
        print("answerHolder found $formId, ${item.toJson().toString()}");
        return item;
      } else {
        print("answerHolder not found $formId, ${item.toJson().toString()}");
      }
    }
    return null;
  }

  //@Query("select * from AnswerHolder where formId = :formId limit 1")
  Future<AnswerHolder?> fetchAnswerHolderAny(int formId, int completed) async {
    //completed == 0 false, 1 true, 2 any
    var r = await getAnswerHolderDb();
    if (completed == HOLDER_ANY_COMPLETED) return r.values.firstWhereOrNull((element) => (element.formId == formId));
    return r.values.firstWhereOrNull((element) => (element.formId == formId) && (element.completed == (completed == HOLDER_NOT_COMPLETED ? false : true)));
  }

  //@Query("select * from AnswerHolder order by id DESC") //createdAt, completedAt
  Future<List<AnswerHolder>?> fetchAllAnswerHolder() async {
    var r = await getAnswerHolderDb();
    //return r.values.sorted((a, b) => a.id!.compareTo(b.id!));
    return r.values.sorted((a, b) => b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())).toList();
  }

  //@Query("select * from AnswerHolder where state = :state order by id DESC") //createdAt, completedAt
  Future<List<AnswerHolder>?> fetchAnswerHolderState(int state) async {
    var r = await getAnswerHolderDb();
    //return r.values.where((element) => element.state == state).sorted((a, b) => a.id!.compareTo(b.id!));
    return r.values.where((element) => element.state == state).sorted((a, b) => b.createdAtTimeStamp().compareTo(a.createdAtTimeStamp())).toList();
  }

  //@Query("update AnswerHolder set uploaded = 1 where id = :id")
  Future<AnswerHolder?> terminateAnswerHolder(int id) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.id == id);
    if (x != null) {
      x.uploaded = true;
      await x.save();
    }
    return x;
  }

  //@Query("update AnswerHolder set closed = 1 where id = :id")
  Future<AnswerHolder?> closeAnswerHolder(int id) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.id == id);
    if (x != null) {
      x.closed = true;
      await x.save();
    }
    return x;
  }

  //@Query("update AnswerHolder set completedAt = :t where id = :id")
  Future<AnswerHolder?> setCompletedTime(String t, int id) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.id == id);
    if (x != null) {
      x.completedAt = t;
      await x.save();
    }
    return x;
  }

  Future<void> deleteAnswerHolderAll() async {
    var r = await getAnswerHolderDb();
    await r.clear();
  }

  //@Query("delete from AnswerHolder where closed = 0 and formId = :formId")
  Future<void> deleteUnclosedAnswerHolder(int formId) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.formId == formId && element.closed == false);
    if (x != null) {
      await x.delete();
    }
  }

  //@Query("delete from AnswerHolder where closed = 0 and id = :id")
  Future<void> deleteAnswerHolder(int id) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.id == id && element.closed == false);
    if (x != null) {
      await x.delete();
    }
  }

  //@Query("select * from FormFields where id = :formId limit 1")
  Future<FormFields?> fetchForm(int formId) async {
    return await fetchForms(formId);
  }

  //@Query("select * from FieldSet where form = :formId limit 1")
  Future<FieldSet?> fetchFieldsOne(int formId) async {
    return await fetchFieldSetOnlyOne(formId);
  }

  Future<FormFields?> loadForm(int formId) async {
    FormFields? form = await fetchForm(formId);
    if (form != null) {
      var d = await fetchFieldsOne(form.id!);
      if (d != null) {
        form.fieldSets = [];
        form.fieldSets!.add(d);
      }
    }
    return form;
  }

  Future<List<AnswerHolder>?> loadAllAnswerHolders() async {
    List<AnswerHolder>? ahs = await fetchAllAnswerHolder();
    //List<Reclamations>? reclamations = await fetchReclamations(formId)
    List<AnswerHolder> ahsTmp = [];
    if (ahs != null) {
      if (ahs.length > 0) {
        for (var ah in ahs) {
          ah.formFields = await loadForm(ah.formId!);
          ah.decisionResponse = await fetchDecisionResponse(ah.id!);
          ah.answers = [];
          List<Answer>? answers = await fetchAnswersOfAnswerHolder(ah.id!);
          if (answers != null) {
            print("transact answers not uploaded size " + answers.length.toString());
            if (answers.length > 0) {
              for (var answer in answers) {
                print("transact answers not uploaded are " + answers.length.toString() + ", " + answer.toString());
                answer.multiSelectAnswer = [];
                answer.question = await fetchQuestionOne(answer.qustionId!);
                List<MultiSelectAnswer>? ms = await fetchMultiSelectAnswers(answer.id!);
                if (ms != null) {
                  print("transact answers not uploaded multi select " + ms.toString());
                  answer.multiSelectAnswer!.addAll(List.from(ms));
                  ah.answers!.add(answer);
                }
              }
            }
          }
          ahsTmp.add(ah);
        }
      }
    }

    return List.from(ahsTmp);
  }

  Future<void> closeAnswerHolders(List<AnswerHolder> answerHolders) async {
    for (var ah in answerHolders) {
      await closeAnswerHolder(ah.id!);
    }
  }

  Future<void> closeAnswerHolderAndSetCompletedTime(AnswerHolder answerHolder) async {
    if (answerHolder.id != null) {
      await setCompletedTime(DateTime.now().toString(), answerHolder.id!);
      await closeAnswerHolder(answerHolder.id!);
    }
  }

  Future<void> teminateAnswerHolders(List<AnswerHolder> answerHolders) async {
    for (var ah in answerHolders) {
      await terminateAnswerHolder(ah.id!);
    }
  }

  Future<void> delete(List<AnswerHolder> answerHolders) async {
    for (var ah in answerHolders) {
      await terminateAnswerHolder(ah.id!);
    }
  }

  Future<List<AnswerHolder>?> fetchAnswerHoldersNotUploadedWithChildren() async {
    List<AnswerHolder>? ahs = await fetchAnswerHoldersNotUploaded();
    List<AnswerHolder> ahsTmp = [];
    if (ahs != null) {
      if (ahs.length > 0) {
        for (var ah in ahs) {
          ah.formFields = await loadForm(ah.formId!);
          ah.decisionResponse = await fetchDecisionResponse(ah.id!);
          ah.answers = [];
          List<Answer>? answers = await fetchAnswersOfAnswerHolder(ah.id!);
          if (answers != null) {
            print("transact answers not uploaded size " + answers.length.toString());
            if (answers.length > 0) {
              for (var answer in answers) {
                print("transact answers not uploaded are " + answers.length.toString() + ", " + answer.toString());
                answer.question = await fetchQuestionOne(answer.qustionId!);
                answer.multiSelectAnswer = [];
                List<MultiSelectAnswer>? ms = await fetchMultiSelectAnswers(answer.id!);
                if (ms != null) {
                  print("transact answers not uploaded multi select " + ms.toString());
                  answer.multiSelectAnswer!.addAll(List.from(ms));
                  ah.answers!.add(answer);
                }
              }
            }
          }
          ahsTmp.add(ah);
        }
      }
    }

    return List.from(ahsTmp);
  }

  Future<AnswerHolder?> fetchAnswerHolderNotClosedWithChildren(int formId, int completed) async {
    AnswerHolder? ah = await fetchAnswerHolderOne(formId, completed); //fetchAnswerHolderNotClosed

    if (ah != null) {
      ah.formFields = await loadFormFieldSets(formId, completed);
      ah.decisionResponse = await fetchDecisionResponse(ah.id!);
      List<Answer>? answers = await fetchAnswersOfAnswerHolder(ah.id!);
      if (answers != null) {
        if (answers.length > 0) {
          ah.answers = [];
          for (var answer in answers) {
            answer.question = await fetchQuestionOne(answer.qustionId!);
            answer.multiSelectAnswer = [];
            List<MultiSelectAnswer>? mA = await fetchMultiSelectAnswers(answer.id!);
            if (mA != null) answer.multiSelectAnswer!.addAll(List.from(mA));
            ah.answers!.add(answer);
          }
          //j
        }
      }
    }

    return ah;
  }

  Future<AnswerHolder?> fetchAnswerHolderWithChildren(
    int formId,
    int completed, {
    bool any = false,
    bool withFormFields = false,
  }) async {
    AnswerHolder? ah;
    if (any)
      ah = await fetchAnswerHolderAny(formId, completed);
    else
      ah = await fetchAnswerHolderOne(formId, completed);
    //print("formId and fieldsetId ara $ah");
    if (ah != null) {
      //print("formId and fieldsetId not null ara ${ah.id}");
      if (withFormFields) ah.formFields = await loadFormFieldSets(formId, completed);
      //print("formId and fieldsetId form fiilds");
      ah.decisionResponse = await fetchDecisionResponse(ah.id!);
      //print("formId and fieldsetId desicision response");
      List<Answer>? answers = await fetchAnswersOfAnswerHolder(ah.id!);
      //print("formId and fieldsetId answers");
      if (answers != null) {
        //print("formId and fieldsetId answers are not null ${answers.length}");
        if (answers.length > 0) {
          ah.answers = [];
          for (Answer answer in answers) {
            answer.question = await fetchQuestionOne(answer.qustionId!);
            answer.multiSelectAnswer = [];
            List<MultiSelectAnswer>? mA = await fetchMultiSelectAnswers(answer.id!);
            if (mA != null) {
              log("answers found == result ${mA.length}, ${answer.qustionId}");
              answer.multiSelectAnswer!.addAll(List.from(mA));
            }
            ah.answers!.add(answer);
          }
          //j
        }
      }
    }
    return ah;
  }

  Future<List<AnswerHolder>> fetchAnswerHolderWithChildrenAll(int uploadedState, int completed) async {
    List<AnswerHolder>? answerHolders;
    if (uploadedState == -1) answerHolders = await fetchAllAnswerHolder();
    if (uploadedState == -2) answerHolders = await fetchAnswerHoldersUploaded();
    if (uploadedState == -3) answerHolders = await fetchAnswerHoldersNotUploaded();

    if (uploadedState > 0) answerHolders = await fetchAnswerHolderState(uploadedState);

    List<AnswerHolder> holders = [];
    if (answerHolders != null) {
      for (var ah in answerHolders) {
        ah.formFields = await loadFormFieldSets(ah.formId!, completed);
        ah.decisionResponse = await fetchDecisionResponse(ah.id!);
        //print("decision response loading ${ah.decisionResponse}, ${ah.id}");
        List<Answer>? answers = await fetchAnswersOfAnswerHolder(ah.id!);
        if (answers != null) {
          if (answers.length > 0) {
            ah.answers = [];
            for (var answer in answers) {
              answer.multiSelectAnswer = [];
              answer.question = await fetchQuestionOne(answer.qustionId!);
              List<MultiSelectAnswer>? mA = await fetchMultiSelectAnswers(answer.id!);
              if (mA != null) answer.multiSelectAnswer!.addAll(List.from(mA));
              ah.answers!.add(answer);
            }
          }
        }
        holders.add(ah);
      }
    }

    return List.from(holders);
  }

  Future<int> insertAnswerHolder(AnswerHolder answer) async {
    answer.id = DateTime.now().millisecondsSinceEpoch;
    var r = await getAnswerHolderDb();
    if (r.values.firstWhereOrNull((element) => element.id == answer.id) != null) return -1;
    await r.add(answer);
    return answer.id!;
    /*AnswerHolder? a = r.getAt(index)!;
    a.id = index;
    await a.save();
    return a.id!;*/
  }

  Future<int> insertAnswerHolderWithId(AnswerHolder answer) async {
    var r = await getAnswerHolderDb();
    if (r.values.firstWhereOrNull((element) => element.id == answer.id) != null) return -1;
    await r.add(answer);
    return answer.id!;
  }

  Future<AnswerHolder?> completeAnswerHolder(int id) async {
    var r = await getAnswerHolderDb();
    AnswerHolder? x = r.values.firstWhereOrNull((element) => element.id == id);
    if (x != null) {
      x.completed = true;
      await x.save();
    }
    return x;
  }

  Future<void> setAnswers(AnswerHolder answerHolder) async {
    if (answerHolder.id != null) {
      await removeAllAnswers(answerHolder.id!);
      await removeAllMultiSelectAnswers(answerHolder.id!);
    }
    if (answerHolder.answers != null) {
      if (answerHolder.answers!.length > 0) {
        for (var answer in answerHolder.answers!) {
          print("saving current answers in object ... " + answer.toString());
          answer.question = await fetchQuestionOne(answer.qustionId!);
          int? answerId = await insertAnswer(answer, answerHolder.id!);
          if (answer.multiSelectAnswer != null) {
            List<MultiSelectAnswer> multi = [];
            for (var ms in answer.multiSelectAnswer!) {
              ms.answerId = answerId;
              multi.add(ms);
            }
            await insertMultiSelectAnswers(multi);
          }
        }
      }
    }
  }
}
