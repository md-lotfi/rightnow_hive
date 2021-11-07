import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'about.g.dart';

@HiveType(typeId: 31)
@JsonSerializable()
class About {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'title')
  String? title;

  @HiveField(2)
  @JsonKey(name: 'title_ar')
  String? titleAr;

  @HiveField(3)
  @JsonKey(name: 'description')
  String? description;

  @HiveField(4)
  @JsonKey(name: 'description_ar')
  String descriptionAr;

  About({
    this.id,
    this.title,
    this.titleAr,
    this.description,
    required this.descriptionAr,
  });

  String getTitle(String? lang) {
    return (lang == LANGUAGE_FR ? title : (lang == null ? title : titleAr)) ?? "";
  }

  String getDescription(String? lang) {
    return (lang == LANGUAGE_FR ? description : (lang == null ? description : descriptionAr)) ?? "";
  }

  factory About.fromJson(Map<String, dynamic> json) => _$AboutFromJson(json);

  Map<String, dynamic> toJson() => _$AboutToJson(this);
}
