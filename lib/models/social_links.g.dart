// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_links.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SocialLinksAdapter extends TypeAdapter<SocialLinks> {
  @override
  final int typeId = 30;

  @override
  SocialLinks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SocialLinks(
      id: fields[0] as int?,
      name: fields[1] as String?,
      nameAr: fields[2] as String?,
      icon: fields[3] as String?,
      link: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SocialLinks obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameAr)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinks _$SocialLinksFromJson(Map<String, dynamic> json) {
  return SocialLinks(
    id: json['id'] as int?,
    name: json['name'] as String?,
    nameAr: json['name_ar'] as String?,
    icon: json['icon'] as String?,
    link: json['link'] as String?,
  );
}

Map<String, dynamic> _$SocialLinksToJson(SocialLinks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'icon': instance.icon,
      'link': instance.link,
    };
