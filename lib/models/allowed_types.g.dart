// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllowedTypesAdapter extends TypeAdapter<AllowedTypes> {
  @override
  final int typeId = 0;

  @override
  AllowedTypes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllowedTypes(
      fields[0] as int?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AllowedTypes obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.extens)
      ..writeByte(4)
      ..write(obj.mimeType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllowedTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedTypes _$AllowedTypesFromJson(Map<String, dynamic> json) {
  return AllowedTypes(
    json['id'] as int?,
    json['name'] as String?,
    json['extension'] as String?,
    json['mime_type'] as String?,
    json['questionId'] as int?,
  );
}

Map<String, dynamic> _$AllowedTypesToJson(AllowedTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'name': instance.name,
      'extension': instance.extens,
      'mime_type': instance.mimeType,
    };
