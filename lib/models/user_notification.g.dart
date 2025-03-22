// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserNotificationAdapter extends TypeAdapter<UserNotification> {
  @override
  final int typeId = 25;

  @override
  UserNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserNotification(
      id: fields[0] as int?,
      titleAr: fields[2] as String?,
      titleFr: fields[1] as String?,
      contentAr: fields[4] as String?,
      contentFr: fields[3] as String?,
      sender: fields[5] as int?,
      targeting: fields[6] as int?,
      createdAt: fields[7] as Jiffy?,
      viewed: fields[8] == null ? 0 : fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserNotification obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleFr)
      ..writeByte(2)
      ..write(obj.titleAr)
      ..writeByte(3)
      ..write(obj.contentFr)
      ..writeByte(4)
      ..write(obj.contentAr)
      ..writeByte(5)
      ..write(obj.sender)
      ..writeByte(6)
      ..write(obj.targeting)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.viewed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNotification _$UserNotificationFromJson(Map<String, dynamic> json) =>
    UserNotification(
      id: (json['id'] as num?)?.toInt(),
      titleAr: json['title_ar'] as String?,
      titleFr: json['title_fr'] as String?,
      contentAr: json['content_ar'] as String?,
      contentFr: json['content_fr'] as String?,
      sender: (json['sender'] as num?)?.toInt(),
      targeting: (json['targeting'] as num?)?.toInt(),
      createdAt:
          const JiffySecondsConverter().fromJson(json['created_at'] as String?),
      viewed: (json['viewed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserNotificationToJson(UserNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title_fr': instance.titleFr,
      'title_ar': instance.titleAr,
      'content_fr': instance.contentFr,
      'content_ar': instance.contentAr,
      'sender': instance.sender,
      'targeting': instance.targeting,
      'created_at': const JiffySecondsConverter().toJson(instance.createdAt),
      'viewed': instance.viewed,
    };
