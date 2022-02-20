import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'UpdateProfileEvent.freezed.dart';

@freezed
abstract class UpdateProfileEvent with _$UpdateProfileEvent {
  const factory UpdateProfileEvent.saveProfile(Map<String, dynamic> profile) = SaveProfile;
  //const factory ActualiteEvent.distract() = Distract;
}
