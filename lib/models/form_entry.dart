import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';

part 'form_entry.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
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
  Jiffy? uploadedAt;

  @HiveField(4)
  @JsonKey(name: "completed_at")
  Jiffy? completedAt;

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

  factory FormEntry.fromJson(Map<String, dynamic> json) =>
      _$FormEntryFromJson(json);

  Map<String, dynamic> toJson() => _$FormEntryToJson(this);
}
