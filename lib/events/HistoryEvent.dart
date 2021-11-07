import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'HistoryEvent.freezed.dart';

@freezed
abstract class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.loadHistory() = LoadHistory;
}
