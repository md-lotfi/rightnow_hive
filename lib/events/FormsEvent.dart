import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'FormsEvent.freezed.dart';

@freezed
abstract class FormsEvent with _$FormsEvent {
  const factory FormsEvent.loadLocalForms() = LoadLocalForms;
  const factory FormsEvent.distract() = Distract;
}
