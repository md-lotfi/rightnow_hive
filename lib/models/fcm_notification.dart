import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fcm_notification.g.dart';

@JsonSerializable()
@HiveType(typeId: 26)
class FCMNotification extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? message;

  @HiveField(3)
  int? viewed;

  FCMNotification({
    this.id,
    this.title,
    this.message,
    this.viewed,
  });

  factory FCMNotification.fromJson(Map<String, dynamic> json) => _$FCMNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$FCMNotificationToJson(this);
}
