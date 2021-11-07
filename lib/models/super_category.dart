import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'super_category.g.dart';

@JsonSerializable()
@HiveType(typeId: 23)
class SuperCategory {
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

  @HiveField(5)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(6)
  @JsonKey(name: 'created_at')
  String? createdAt;

  //List<Tag>? tags;

  //List<CategoryMiddle>? categories;

  @JsonKey(ignore: true)
  String title(String? lang) {
    print("currrent language $lang");
    return (lang == LANGUAGE_FR ? name : nameAr) ?? name ?? "";
  }

  SuperCategory(this.id, this.name, this.nameAr, this.nameFr, this.icon, this.createdAt);

  factory SuperCategory.fromJson(Map<String, dynamic> json) => _$SuperCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SuperCategoryToJson(this);
}
