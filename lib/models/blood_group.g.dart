// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodGroupAdapter extends TypeAdapter<BloodGroup> {
  @override
  final int typeId = 3;

  @override
  BloodGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodGroup(
      fields[0] as int?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodGroup obj) {
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
      other is BloodGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodGroup _$BloodGroupFromJson(Map<String, dynamic> json) => BloodGroup(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$BloodGroupToJson(BloodGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
