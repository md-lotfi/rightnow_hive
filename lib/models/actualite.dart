import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'actualite.g.dart';

@JsonSerializable()
class Actualite {
  int? id;

  @JsonKey(name: 'state_name')
  String? stateName;

  @JsonKey(name: 'type_name')
  String? typeName;

  @JsonKey(name: 'state')
  int? state;

  @JsonKey(name: 'type')
  int? type;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'title_ar')
  String? titleAr;

  @JsonKey(name: 'is_important')
  bool? isImportant;

  @JsonKey(name: 'thumbnail')
  String? thumbnail;

  @JsonKey(name: 'link')
  String? link;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "updated_at")
  String? updatedAt;

  @JsonKey(name: "content")
  String? content;

  @JsonKey(name: "content_ar")
  String? contentAr;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "resourcetype")
  String? resourceType;

  String getTitle(String? lang) {
    return (lang == LANGUAGE_FR ? title : titleAr) ?? "";
  }

  String getContent(String? lang) {
    return (lang == LANGUAGE_FR ? content : contentAr) ?? "";
  }

  String getDescription(String? lang) {
    return (lang == LANGUAGE_FR ? description : descriptionAr) ?? "";
  }

  int createdAtTimeStamp() {
    return Jiffy(createdAt).unix();
  }

  Actualite({
    this.id,
    this.stateName,
    this.typeName,
    this.state,
    this.type,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.image,
    this.resourceType,
    this.description,
    this.link,
    this.isImportant,
    this.thumbnail,
    this.contentAr,
    this.descriptionAr,
    this.titleAr,
  });

  factory Actualite.fromJson(Map<String, dynamic> json) => _$ActualiteFromJson(json);

  Map<String, dynamic> toJson() => _$ActualiteToJson(this);
}
