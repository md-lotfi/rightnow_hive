import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'link.g.dart';

@HiveType(typeId: 111)
@JsonSerializable()
class Link {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'title')
  String? title;

  @HiveField(2)
  @JsonKey(name: 'title_ar')
  String? titleAr;

  @HiveField(3)
  @JsonKey(name: 'icon')
  String? icon;

  @HiveField(4)
  @JsonKey(name: 'link')
  String? linkUrl;

  Link({
    this.id,
    this.title,
    this.titleAr,
    this.icon,
    this.linkUrl,
  });

  String getTitle(String? lang) {
    return (lang == LANGUAGE_FR ? title : (lang == null ? title : titleAr)) ?? "";
  }

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
