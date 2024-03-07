// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrganisationAdapter extends TypeAdapter<Organisation> {
  @override
  final int typeId = 36;

  @override
  Organisation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Organisation(
      orgKey: fields[0] as String?,
      name: fields[1] as String?,
      logo: fields[2] as String?,
      icon: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Organisation obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.orgKey)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logo)
      ..writeByte(3)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganisationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisation _$OrganisationFromJson(Map<String, dynamic> json) => Organisation(
      orgKey: json['org_key'] as String?,
      name: json['name'] as String?,
      logo: json['logo'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$OrganisationToJson(Organisation instance) =>
    <String, dynamic>{
      'org_key': instance.orgKey,
      'name': instance.name,
      'logo': instance.logo,
      'icon': instance.icon,
    };
