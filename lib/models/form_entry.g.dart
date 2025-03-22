// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormEntryAdapter extends TypeAdapter<FormEntry> {
  @override
  final int typeId = 27;

  @override
  FormEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormEntry(
      id: fields[0] as int?,
      form: fields[1] as int?,
      user: fields[2] as int?,
      uploadedAt: fields[3] as Jiffy?,
      completedAt: fields[4] as Jiffy?,
      deviceId: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FormEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.form)
      ..writeByte(2)
      ..write(obj.user)
      ..writeByte(3)
      ..write(obj.uploadedAt)
      ..writeByte(4)
      ..write(obj.completedAt)
      ..writeByte(5)
      ..write(obj.deviceId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormEntry _$FormEntryFromJson(Map<String, dynamic> json) => FormEntry(
      id: (json['id'] as num?)?.toInt(),
      form: (json['form'] as num?)?.toInt(),
      user: (json['user'] as num?)?.toInt(),
      uploadedAt: const JiffySecondsConverter()
          .fromJson(json['uploaded_at'] as String?),
      completedAt: const JiffySecondsConverter()
          .fromJson(json['completed_at'] as String?),
      deviceId: json['device_id'] as String?,
    );

Map<String, dynamic> _$FormEntryToJson(FormEntry instance) => <String, dynamic>{
      'id': instance.id,
      'form': instance.form,
      'user': instance.user,
      'uploaded_at': const JiffySecondsConverter().toJson(instance.uploadedAt),
      'completed_at':
          const JiffySecondsConverter().toJson(instance.completedAt),
      'device_id': instance.deviceId,
    };
