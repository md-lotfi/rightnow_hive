import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rightnow/db/MultiSelectAnswersDao.dart';
import 'package:rightnow/models/answer.dart';
import 'package:collection/collection.dart';

class AnswersDao extends MultiSelectAnswersDao {
  Future<Box<Answer>> getAnswerDb() async {
    return await Hive.openBox<Answer>('Answer');
  }

  //@Query("select * from Answer where questionId = :questionId and fieldSetId = :fieldSetId limit 1")
  Future<Answer?> fetchQuestionAnswer(int questionId, int fieldSetId) async {
    var r = await getAnswerDb();
    return r.values.firstWhereOrNull((element) => element.qustionId == questionId && element.fieldSetId == fieldSetId);
  }

  //@Query("select * from Answer where fieldSetId = :fieldSetId and answerHolderId = :answerHolderId")
  Future<List<Answer>?> fetchFiledSetAnswers(int fieldSetId, int answerHolderId) async {
    var r = await getAnswerDb();
    return r.values.where((element) => element.fieldSetId == fieldSetId && element.answerHolderId == answerHolderId).toList();
  }

  //@Query("select * from Answer where answerHolderId = :answerHolderId")
  Future<List<Answer>?> fetchAnswersOfAnswerHolder(int answerHolderId, int? fieldSetId) async {
    var r = await getAnswerDb();
    List<Answer> answers = [];
    for (Answer item in r.values) {
      log("fetching answers ${item.answerHolderId}, $answerHolderId, ${item.fieldSetId}, $fieldSetId");
      if (item.answerHolderId == answerHolderId && (item.fieldSetId == fieldSetId || fieldSetId == null)) {
        log("fetching answers equlas ${item.answerHolderId}, $answerHolderId");
        answers.add(item);
      }
    }
    return answers;
    //return r.values.where((element) => element.answerHolderId == answerHolderId).toList();
  }

  //@Query("delete from Answer where answerHolderId = :answerHolderId")
  Future<void> removeAllAnswers(int answerHolderId) async {
    var r = await getAnswerDb();
    for (var item in r.values) {
      if (item.answerHolderId == answerHolderId) await item.delete();
    }
    /*final Map<dynamic, Answer> answers = r.toMap();

    answers.forEach((key, value) async {
      print("deleting anwer key check $key, $answerHolderId, ${value.answerHolderId}");
      if (value.answerHolderId == answerHolderId) {
        print("deleting anwer key $key");
        await r.delete(key);
      }
    });*/
    //await r.delet
  }

  Future<int> insertAnswer(Answer answer, int answerHolderId) async {
    var r = await getAnswerDb();
    /*if (answer.id != null) {
      Answer? a = r.values.firstWhereOrNull((element) {
        if ((element.qustionId == answer.qustionId) || (element.answerHolderId == answerHolderId)) {
          return true;
        }
        return false;
      });
      if (a != null) {
        print("saving current answers in object found ${a.key}");
        await r.put(a.key, answer);
        return answer.id!;
      }
    }*/
    final exists = r.containsKey(answer.key);
    if (!exists) {
      print("saving current answers in object normal ${answer.key}");
      answer.id = DateTime.now().millisecondsSinceEpoch;
      //await r.add(answer);
      //return answer.id!;
      await r.add(answer);
    }
    await answer.save();
    return answer.id!;
    //return r.getAt(key)!.id!;
  }

  Future<void> insertAnswers(List<Answer> answer) async {
    var r = await getAnswerDb();
    await r.addAll(answer);
  }
}
