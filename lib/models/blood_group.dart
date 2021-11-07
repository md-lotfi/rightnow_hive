import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blood_group.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class BloodGroup {
  @HiveField(0)
  int? id;

  @JsonKey(name: "name")
  @HiveField(1)
  String? name;

  BloodGroup(this.id, this.name);

  factory BloodGroup.fromJson(Map<String, dynamic> json) => _$BloodGroupFromJson(json);

  Map<String, dynamic> toJson() => _$BloodGroupToJson(this);
}
