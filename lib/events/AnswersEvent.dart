import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'AnswersEvent.freezed.dart';

@freezed
abstract class AnswersEvent with _$AnswersEvent {
  const factory AnswersEvent.uploadAnswerHolder() = UploadAnswerHolder;
  const factory AnswersEvent.distract() = Distract;
}
