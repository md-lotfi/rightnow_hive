import 'package:rightnow/models/Question.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'FieldSet.g.dart';

@JsonSerializable()
@HiveType(typeId: 14)
class FieldSet extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? form;

  @HiveField(2)
  @JsonKey(name: 'questions_count')
  int? questionsCount;

  @HiveField(3)
  @JsonKey(name: 'required')
  int? required;

  @HiveField(4)
  int? qCounts = 0;

  @HiveField(5)
  int? qAnswered = 0;

  @HiveField(6)
  int? flag;

  @HiveField(7)
  String? title;

  @HiveField(8)
  @JsonKey(name: 'title_ar')
  String? titleAr;

  @HiveField(9)
  @JsonKey(name: 'description')
  String? description;

  @HiveField(10)
  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? title : titleAr) ?? "";
  }

  String getDescription(String? lang) {
    return (lang == LANGUAGE_FR ? description : descriptionAr) ?? "";
  }

  List<Question>? questions;

  FieldSet(
    this.id,
    this.form,
    this.questionsCount,
    this.flag,
    this.title,
    this.titleAr,
  );

  factory FieldSet.fromJson(Map<String, dynamic> json) => _$FieldSetFromJson(json);

  Map<String, dynamic> toJson() => _$FieldSetToJson(this);

  static Future<Box<FieldSet>> getFieldSetDb() async {
    return await Hive.openBox<FieldSet>('FieldSet');
  }

  //@Query("select * from FieldSet where form = :formId")
  static Future<List<FieldSet>> fetchFields(int formId) async {
    var f = await getFieldSetDb();
    return f.values.where((element) => element.form == formId).toList();
  }
}
