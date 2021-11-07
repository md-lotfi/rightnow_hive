import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ReclamationsEvent.freezed.dart';

@freezed
abstract class ReclamationsEvent with _$ReclamationsEvent {
  const factory ReclamationsEvent.myReclamations() = MyReclamations;
}
