import 'package:rightnow/models/AnswersHolder.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "FieldsetsEvent.freezed.dart";

@freezed
abstract class FieldsetsEvent with _$FieldsetsEvent {
  const factory FieldsetsEvent.loadLocalFieldSets(int formId) = LoadLocalFieldSets;
  //const factory FieldsetsEvent.uploadAnswerHolder(AnswerHolder answerHolder) = UploadAnswerHolder;
}
