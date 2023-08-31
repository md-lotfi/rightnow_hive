import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'response_question_hist.g.dart';

@JsonSerializable()
@HiveType(typeId: 103)
class ResponseQuestionHist extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'label')
  String? label;

  @HiveField(2)
  @JsonKey(name: 'label_ar')
  String? labaleAr;

  @HiveField(3)
  @JsonKey(name: 'field_set')
  int? fieldSet;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? label : labaleAr) ?? "";
  }

  ResponseQuestionHist({
    this.id,
    this.label,
    this.labaleAr,
    this.fieldSet,
  });

  factory ResponseQuestionHist.fromJson(Map<String, dynamic> json) => _$ResponseQuestionHistFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseQuestionHistToJson(this);
}
