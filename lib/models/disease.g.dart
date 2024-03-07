// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disease.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiseaseAdapter extends TypeAdapter<Disease> {
  @override
  final int typeId = 12;

  @override
  Disease read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Disease(
      fields[0] as int?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Disease obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Disease _$DiseaseFromJson(Map<String, dynamic> json) => Disease(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$DiseaseToJson(Disease instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
