import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'social_links.g.dart';

@HiveType(typeId: 30)
@JsonSerializable()
class SocialLinks {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(2)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(3)
  @JsonKey(name: 'icon')
  String? icon;

  @HiveField(4)
  @JsonKey(name: 'link')
  String? link;

  SocialLinks({
    this.id,
    this.name,
    this.nameAr,
    this.icon,
    this.link,
  });

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? name : (lang == null ? name : nameAr)) ?? "";
  }

  factory SocialLinks.fromJson(Map<String, dynamic> json) => _$SocialLinksFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinksToJson(this);
}
