// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormFieldsStateAdapter extends TypeAdapter<FormFieldsState> {
  @override
  final int typeId = 15;

  @override
  FormFieldsState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormFieldsState(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FormFieldsState obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameAr)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFieldsStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFieldsState _$FormFieldsStateFromJson(Map<String, dynamic> json) {
  return FormFieldsState(
    json['id'] as int?,
    json['name'] as String?,
    json['name_ar'] as String?,
    json['created_at'] as String?,
  );
}

Map<String, dynamic> _$FormFieldsStateToJson(FormFieldsState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'created_at': instance.createdAt,
    };
