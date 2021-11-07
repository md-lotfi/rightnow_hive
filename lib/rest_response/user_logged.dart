import 'package:json_annotation/json_annotation.dart';

part 'user_logged.g.dart';

@JsonSerializable()
class UserLogged {
  final String token;

  UserLogged(this.token);

  factory UserLogged.fromJson(Map<String, dynamic> json) => _$UserLoggedFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoggedToJson(this);
}
