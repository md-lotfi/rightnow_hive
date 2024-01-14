import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'login_error.g.dart';

@JsonSerializable()
class LoginError {
  int? status;
  String? message;
  String? error;

  LoginError({
    this.status,
    this.message,
    this.error,
  });

  factory LoginError.fromJson(Map<String, dynamic> json) => _$LoginErrorFromJson(json);

  Map<String, dynamic> toJson() => _$LoginErrorToJson(this);
}
