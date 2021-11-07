import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'QuestionsEvent.freezed.dart';

@freezed
abstract class QuestionsEvent with _$QuestionsEvent {
  const factory QuestionsEvent.loadQuestions(int fieldSetId) = LoadQuestions;
  const factory QuestionsEvent.distract() = Distract;
}
