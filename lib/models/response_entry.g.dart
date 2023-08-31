// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseEntryAdapter extends TypeAdapter<ResponseEntry> {
  @override
  final int typeId = 101;

  @override
  ResponseEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseEntry(
      id: fields[0] as int?,
      uploadedAt: fields[1] as String?,
      completedAt: fields[2] as String?,
      deviceId: fields[3] as String?,
      form: fields[4] as int?,
      user: fields[5] as int?,
      responseSet: (fields[6] as List?)?.cast<ResponseSet>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResponseEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.uploadedAt)
      ..writeByte(2)
      ..write(obj.completedAt)
      ..writeByte(3)
      ..write(obj.deviceId)
      ..writeByte(4)
      ..write(obj.form)
      ..writeByte(5)
      ..write(obj.user)
      ..writeByte(6)
      ..write(obj.responseSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseEntry _$ResponseEntryFromJson(Map<String, dynamic> json) {
  return ResponseEntry(
    id: json['id'] as int?,
    uploadedAt: json['uploaded_at'] as String?,
    completedAt: json['completed_at'] as String?,
    deviceId: json['device_id'] as String?,
    form: json['form'] as int?,
    user: json['user'] as int?,
    responseSet: (json['response_set'] as List<dynamic>?)
        ?.map((e) => ResponseSet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ResponseEntryToJson(ResponseEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uploaded_at': instance.uploadedAt,
      'completed_at': instance.completedAt,
      'device_id': instance.deviceId,
      'form': instance.form,
      'user': instance.user,
      'response_set': instance.responseSet,
    };
