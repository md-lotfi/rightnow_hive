import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/views/language_switch.dart';

part 'form_state.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 15)
class FormFieldsState {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  @HiveField(2)
  @JsonKey(name: "name_ar")
  String? nameAr;

  @HiveField(3)
  @JsonKey(name: "created_at")
  Jiffy? createdAt;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? name : nameAr) ?? "";
  }

  FormFieldsState(this.id, this.name, this.nameAr, this.createdAt);

  factory FormFieldsState.fromJson(Map<String, dynamic> json) =>
      _$FormFieldsStateFromJson(json);

  Map<String, dynamic> toJson() => _$FormFieldsStateToJson(this);
}
