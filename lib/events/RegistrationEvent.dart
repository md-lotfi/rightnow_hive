import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'RegistrationEvent.freezed.dart';

@freezed
abstract class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.registerUser(LocalUser localUser) = RegisterUser;
  const factory RegistrationEvent.loginUser(LocalUser localUser) = LoginUser;
  const factory RegistrationEvent.getUser() = GetUser;
  const factory RegistrationEvent.getUserProfile() = GetUserProfile;
  const factory RegistrationEvent.setUserProfile(Profile profile) = SetUserProfile;
  const factory RegistrationEvent.distract() = Distract;
}
