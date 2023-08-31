import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/models/response_set.dart';

part 'response_entry.g.dart';

@JsonSerializable()
@HiveType(typeId: 101)
class ResponseEntry extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'uploaded_at')
  String? uploadedAt;

  @HiveField(2)
  @JsonKey(name: 'completed_at')
  String? completedAt;

  @HiveField(3)
  @JsonKey(name: 'device_id')
  String? deviceId;

  @HiveField(4)
  @JsonKey(name: 'form')
  int? form;

  @HiveField(5)
  @JsonKey(name: 'user')
  int? user;

  @HiveField(6)
  @JsonKey(name: 'response_set')
  List<ResponseSet>? responseSet;

  ResponseEntry({
    this.id,
    this.uploadedAt,
    this.completedAt,
    this.deviceId,
    this.form,
    this.user,
    this.responseSet,
  });

  factory ResponseEntry.fromJson(Map<String, dynamic> json) => _$ResponseEntryFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEntryToJson(this);
}
