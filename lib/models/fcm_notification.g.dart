// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FCMNotificationAdapter extends TypeAdapter<FCMNotification> {
  @override
  final int typeId = 26;

  @override
  FCMNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FCMNotification(
      id: fields[0] as int?,
      title: fields[1] as String?,
      message: fields[2] as String?,
      viewed: fields[3] == null ? 0 : fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, FCMNotification obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.message)
      ..writeByte(3)
      ..write(obj.viewed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FCMNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FCMNotification _$FCMNotificationFromJson(Map<String, dynamic> json) =>
    FCMNotification(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      message: json['message'] as String?,
      viewed: (json['viewed'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FCMNotificationToJson(FCMNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'viewed': instance.viewed,
    };
