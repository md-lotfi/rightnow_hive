// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SuperCategoryAdapter extends TypeAdapter<SuperCategory> {
  @override
  final int typeId = 23;

  @override
  SuperCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SuperCategory(
      fields[0] as int?,
      fields[5] as String?,
      fields[3] as String?,
      fields[2] as String?,
      fields[1] as String?,
      fields[6] as Jiffy?,
    );
  }

  @override
  void write(BinaryWriter writer, SuperCategory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.nameFr)
      ..writeByte(3)
      ..write(obj.nameAr)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SuperCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperCategory _$SuperCategoryFromJson(Map<String, dynamic> json) =>
    SuperCategory(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['name_ar'] as String?,
      json['name_fr'] as String?,
      json['icon'] as String?,
      const JiffySecondsConverter().fromJson(json['created_at'] as String?),
    );

Map<String, dynamic> _$SuperCategoryToJson(SuperCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name_fr': instance.nameFr,
      'name_ar': instance.nameAr,
      'name': instance.name,
      'created_at': const JiffySecondsConverter().toJson(instance.createdAt),
    };
