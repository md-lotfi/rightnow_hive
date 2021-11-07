import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable()
@HiveType(typeId: 18)
class LocalUser {
  @HiveField(0)
  int? user;

  @HiveField(2)
  String? username;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? password;

  @HiveField(5)
  String? organization;

  //int user;

  LocalUser(this.username, this.password, this.email, this.organization, this.user);

  LocalUser.fill({this.username, this.password, this.organization});

  factory LocalUser.fromJson(Map<String, dynamic> json) => _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
