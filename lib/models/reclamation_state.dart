import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'reclamation_state.g.dart';

@HiveType(typeId: 112)
@JsonSerializable()
class ReclamationState extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(2)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  ReclamationState({
    this.id,
    this.name,
    this.nameAr,
  });

  String getTitle(String? lang) {
    return (lang == LANGUAGE_FR ? name : (lang == null ? nameAr : nameAr)) ?? "";
  }

  factory ReclamationState.fromJson(Map<String, dynamic> json) => _$ReclamationStateFromJson(json);

  Map<String, dynamic> toJson() => _$ReclamationStateToJson(this);
}
