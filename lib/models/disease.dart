import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'disease.g.dart';

@JsonSerializable()
@HiveType(typeId: 12)
class Disease {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  Disease(this.id, this.name);

  factory Disease.fromJson(Map<String, dynamic> json) => _$DiseaseFromJson(json);

  Map<String, dynamic> toJson() => _$DiseaseToJson(this);
}
