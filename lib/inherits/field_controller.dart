import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerDao.dart';
import 'package:rightnow/models/answer.dart';
import 'package:flutter/material.dart';

mixin FiledController {
  final fieldDataController = TextEditingController();

  void saveFieldToDb(Answer answer) {
    getDataBase<AnswersDao>().insertAnswer(answer, answer.answerHolderId ?? -1);
  }
}
