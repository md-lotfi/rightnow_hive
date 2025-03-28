import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/views/language_switch.dart';

part 'user_notification.g.dart';

@HiveType(typeId: 25)
@JiffySecondsConverter()
@JsonSerializable()
class UserNotification extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'title_fr')
  String? titleFr;

  @HiveField(2)
  @JsonKey(name: 'title_ar')
  String? titleAr;

  @HiveField(3)
  @JsonKey(name: 'content_fr')
  String? contentFr;

  @HiveField(4)
  @JsonKey(name: 'content_ar')
  String? contentAr;

  @HiveField(5)
  int? sender;

  @HiveField(6)
  int? targeting;

  @HiveField(7)
  @JsonKey(name: 'created_at')
  Jiffy? createdAt;

  @HiveField(8, defaultValue: 0)
  int? viewed;

  String getTitle(String? lang) {
    return (lang == LANGUAGE_FR
            ? titleFr
            : (lang == null ? titleFr : titleAr)) ??
        "";
  }

  String getContent(String? lang) {
    return (lang == LANGUAGE_FR
            ? contentFr
            : (lang == null ? contentFr : contentAr)) ??
        "";
  }

  UserNotification({
    this.id,
    this.titleAr,
    this.titleFr,
    this.contentAr,
    this.contentFr,
    this.sender,
    this.targeting,
    this.createdAt,
    this.viewed,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$UserNotificationToJson(this);
}
