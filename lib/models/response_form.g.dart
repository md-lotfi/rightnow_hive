// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_form.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseFormAdapter extends TypeAdapter<ResponseForm> {
  @override
  final int typeId = 100;

  @override
  ResponseForm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseForm(
      name: fields[0] as String?,
      nameAr: fields[1] as String?,
      entries: (fields[2] as List?)?.cast<ResponseEntry>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResponseForm obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.nameAr)
      ..writeByte(2)
      ..write(obj.entries);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseFormAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseForm _$ResponseFormFromJson(Map<String, dynamic> json) => ResponseForm(
      name: json['name'] as String?,
      nameAr: json['name_ar'] as String?,
      entries: (json['entries'] as List<dynamic>?)
          ?.map((e) => ResponseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseFormToJson(ResponseForm instance) =>
    <String, dynamic>{
      'name': instance.name,
      'name_ar': instance.nameAr,
      'entries': instance.entries,
    };
