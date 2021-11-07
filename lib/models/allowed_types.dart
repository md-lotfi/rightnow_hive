import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allowed_types.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AllowedTypes {
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;

  @HiveField(1)
  int? questionId;

  @HiveField(2)
  @JsonKey(name: "name")
  String? name;

  @HiveField(3)
  @JsonKey(name: "extension")
  String? extens;

  @HiveField(4)
  @JsonKey(name: "mime_type")
  String? mimeType;

  AllowedTypes(this.id, this.name, this.extens, this.mimeType, this.questionId);

  factory AllowedTypes.fromJson(Map<String, dynamic> json) => _$AllowedTypesFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedTypesToJson(this);
}
