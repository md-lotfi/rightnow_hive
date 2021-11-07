import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ActualiteEvent.freezed.dart';

@freezed
abstract class ActualiteEvent with _$ActualiteEvent {
  const factory ActualiteEvent.getActualite() = GetActualite;
  const factory ActualiteEvent.distract() = Distract;
}
