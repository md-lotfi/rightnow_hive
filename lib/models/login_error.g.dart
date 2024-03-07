// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginError _$LoginErrorFromJson(Map<String, dynamic> json) => LoginError(
      status: json['status'] as int?,
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$LoginErrorToJson(LoginError instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'error': instance.error,
    };
