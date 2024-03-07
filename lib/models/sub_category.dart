import 'package:jiffy/jiffy.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/category_forms.dart';
import 'package:rightnow/models/tag.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'sub_category.g.dart';

@JsonSerializable()
@HiveType(typeId: 110)
class SubCategory {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? icon;

  @HiveField(2)
  @JsonKey(name: 'name')
  String? nameFr;

  @HiveField(3)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(4)
  @JsonKey(ignore: true)
  int? superCategoryId;

  @HiveField(5)
  @JsonKey(name: 'created_at')
  String? createdAt;

  List<Tag>? tags;

  @HiveField(7)
  @JsonKey(name: 'belongs_to')
  Category? belongsTo;

  @HiveField(8)
  int? categoryId;

  List<CategoryForms>? subcategories;

  String getName(String? lang) {
    print('getting languge of code ' + lang!);
    return (lang == LANGUAGE_FR ? nameFr : nameAr) ?? "";
  }

  int createdAtTimeStamp() {
    return Jiffy.parse(createdAt ?? Jiffy.now().format()).microsecondsSinceEpoch;
  }

  SubCategory(this.id, this.nameAr, this.nameFr, this.icon, this.createdAt);

  factory SubCategory.fromJson(Map<String, dynamic> json) => _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}
