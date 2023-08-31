// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkAdapter extends TypeAdapter<Link> {
  @override
  final int typeId = 111;

  @override
  Link read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Link(
      id: fields[0] as int?,
      title: fields[1] as String?,
      titleAr: fields[2] as String?,
      icon: fields[3] as String?,
      linkUrl: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Link obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleAr)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.linkUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) {
  return Link(
    id: json['id'] as int?,
    title: json['title'] as String?,
    titleAr: json['title_ar'] as String?,
    icon: json['icon'] as String?,
    linkUrl: json['link'] as String?,
  );
}

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'icon': instance.icon,
      'link': instance.linkUrl,
    };
