// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AboutAdapter extends TypeAdapter<About> {
  @override
  final int typeId = 31;

  @override
  About read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return About(
      id: fields[0] as int?,
      title: fields[1] as String?,
      titleAr: fields[2] as String?,
      description: fields[3] as String?,
      descriptionAr: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, About obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.titleAr)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.descriptionAr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AboutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

About _$AboutFromJson(Map<String, dynamic> json) {
  return About(
    id: json['id'] as int?,
    title: json['title'] as String?,
    titleAr: json['title_ar'] as String?,
    description: json['description'] as String?,
    descriptionAr: json['description_ar'] as String,
  );
}

Map<String, dynamic> _$AboutToJson(About instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
    };
