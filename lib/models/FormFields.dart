import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/views/language_switch.dart';

part 'FormFields.g.dart';

@JsonSerializable()
@HiveType(typeId: 16)
class FormFields {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? icon;

  @JsonKey(name: 'field_sets')
  List<FieldSet>? fieldSets;

  @JsonKey(name: 'category')
  Category? category;

  @HiveField(2)
  @JsonKey(ignore: true)
  int? categoryId;

  @JsonKey(ignore: true)
  AnswerHolder? answerHolder;

  @JsonKey(ignore: true)
  Reclamations? reclamations;

  @JsonKey(name: 'name')
  @HiveField(3)
  String? name;

  @HiveField(4)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(5)
  @JsonKey(name: 'description')
  String? description;

  @HiveField(6)
  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  @HiveField(7)
  @JsonKey(name: 'created_at')
  String? createdAt;

  @HiveField(15)
  @JsonKey(ignore: true)
  int? createdAtTimeStamp;

  @HiveField(8)
  @JsonKey(name: 'is_active')
  bool? isActive;

  @HiveField(9)
  @JsonKey(name: 'is_anonymous')
  bool? isAnonymous;

  @HiveField(10)
  @JsonKey(name: 'active_until')
  String? activeUntil;

  @HiveField(11)
  @JsonKey(name: 'success_page_title')
  String? successPageTitle;

  @HiveField(12)
  @JsonKey(name: 'success_page_body')
  String? successPageBody;

  @HiveField(13)
  @JsonKey(name: 'form_inactive_page_title')
  String? formInactivePageTitle;

  @HiveField(14)
  @JsonKey(name: 'form_inactive_page_body')
  String? formInactivePageBody;

  String getName(String? lang) {
    //return name ?? "";
    return (lang == LANGUAGE_FR ? name : nameAr) ?? "";
  }

  String getDescription(String? lang) {
    print("get description  of language $lang");
    var r = (lang == LANGUAGE_FR ? description : (lang == null ? description : descriptionAr)) ?? "";
    print("get description  of language final  $r");
    return r;
  }

  FormFields(
      {this.nameAr,
      this.name,
      this.id,
      this.description,
      this.descriptionAr,
      this.createdAt,
      this.createdAtTimeStamp,
      this.isActive,
      this.activeUntil,
      this.successPageTitle,
      this.successPageBody,
      this.icon,
      this.reclamations,
      this.isAnonymous,
      this.categoryId,
      this.formInactivePageTitle,
      this.formInactivePageBody});

  factory FormFields.fromJson(Map<String, dynamic> json) => _$FormFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FormFieldsToJson(this);
}
