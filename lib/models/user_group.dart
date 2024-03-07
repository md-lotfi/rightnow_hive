import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'user_group.g.dart';

@HiveType(typeId: 220)
@JsonSerializable()
class UserGroup {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;
  UserGroup({
    this.id,
    this.name,
  });

  factory UserGroup.fromJson(Map<String, dynamic> json) => _$UserGroupFromJson(json);

  Map<String, dynamic> toJson() => _$UserGroupToJson(this);
}
