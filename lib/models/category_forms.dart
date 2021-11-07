import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/tag.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'category_forms.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class CategoryForms {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? icon;

  @HiveField(2)
  String? name;

  @HiveField(3)
  @JsonKey(name: 'name_fr')
  String? nameFr;

  @HiveField(4)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(5)
  @JsonKey(name: 'belongs_to')
  int? belongsTo;

  @HiveField(6)
  @JsonKey(name: 'created_at')
  String? createdAt;

  List<Tag>? tags;

  List<FormFields>? forms;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? name : nameAr) ?? name ?? "";
  }

  CategoryForms(this.id, this.name, this.nameAr, this.nameFr, this.icon, this.belongsTo, this.createdAt);

  factory CategoryForms.fromJson(Map<String, dynamic> json) => _$CategoryFormsFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryFormsToJson(this);
}
