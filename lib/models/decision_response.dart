import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'decision_response.g.dart';

@JsonSerializable()
@HiveType(typeId: 10)
class DecisionResponse {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? answerHolderId;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? text;

  @HiveField(4)
  @JsonKey(name: 'title_ar')
  String? titleAr;

  @HiveField(5)
  @JsonKey(name: 'text_ar')
  String? textAr;

  @HiveField(6)
  String? image;

  @HiveField(7)
  String? url;

  @HiveField(8)
  String? sound;

  @HiveField(9)
  @JsonKey(name: 'text_active')
  bool? textActive;

  @HiveField(10)
  @JsonKey(name: 'image_active')
  bool? imageActive;

  @HiveField(11)
  @JsonKey(name: 'url_active')
  bool? urlActive;

  @HiveField(12)
  @JsonKey(name: 'sound_active')
  bool? soundActive;

  @HiveField(13)
  @JsonKey(name: 'default')
  bool? defaultResponse;

  @HiveField(14)
  int? algorithme;
  DecisionResponse({
    this.id,
    this.title,
    this.text,
    this.image,
    this.url,
    this.sound,
    this.textActive,
    this.imageActive,
    this.urlActive,
    this.soundActive,
    this.defaultResponse,
    this.algorithme,
    this.answerHolderId,
    this.textAr,
    this.titleAr,
  });

  String getTitle(String? lang) {
    print('getting languge of code ' + lang!);
    return (lang == LANGUAGE_FR ? title : titleAr) ?? "";
  }

  String getText(String? lang) {
    print('getting languge of code ' + lang!);
    return (lang == LANGUAGE_FR ? text : textAr) ?? "";
  }

  factory DecisionResponse.fromJson(Map<String, dynamic> json) => _$DecisionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DecisionResponseToJson(this);
}
