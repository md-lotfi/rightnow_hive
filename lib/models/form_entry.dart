import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'form_entry.g.dart';

@JsonSerializable()
@HiveType(typeId: 27)
class FormEntry {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "form")
  int? form;

  @HiveField(2)
  @JsonKey(name: "user")
  int? user;

  @HiveField(3)
  @JsonKey(name: "uploaded_at")
  String? uploadedAt;

  @HiveField(4)
  @JsonKey(name: "completed_at")
  String? completedAt;

  @HiveField(5)
  @JsonKey(name: "device_id")
  String? deviceId;

  FormEntry({
    this.id,
    this.form,
    this.user,
    this.uploadedAt,
    this.completedAt,
    this.deviceId,
  });

  factory FormEntry.fromJson(Map<String, dynamic> json) => _$FormEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FormEntryToJson(this);
}
