import 'package:jiffy/jiffy.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/category_forms.dart';
import 'package:rightnow/models/tag.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'category_middle.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 7)
class CategoryMiddle {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? icon;

  @HiveField(2)
  @JsonKey(name: 'name_fr')
  String? nameFr;

  @HiveField(3)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(4)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(5)
  @JsonKey(name: 'belongs_to')
  int? belongsTo;

  @HiveField(6)
  @JsonKey(name: 'created_at')
  Jiffy? createdAt;

  List<Tag>? tags;

  List<CategoryForms>? subcategories;

  String getName(String? lang) {
    print('getting languge of code ' + lang!);
    return (lang == LANGUAGE_FR ? name : nameAr) ?? name ?? "";
  }

  CategoryMiddle(this.id, this.name, this.nameAr, this.nameFr, this.icon,
      this.belongsTo, this.createdAt);

  factory CategoryMiddle.fromJson(Map<String, dynamic> json) =>
      _$CategoryMiddleFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryMiddleToJson(this);
}
