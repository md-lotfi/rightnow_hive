// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reclamations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReclamationsAdapter extends TypeAdapter<Reclamations> {
  @override
  final int typeId = 22;

  @override
  Reclamations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reclamations(
      id: fields[0] as int?,
      state: fields[1] as int?,
      formEntry: fields[5] as FormEntry?,
      deviceId: fields[3] as String?,
      user: fields[4] as int?,
      createdAt: fields[6] as String?,
      form: fields[7] as String?,
    )..formId = fields[2] as int?;
  }

  @override
  void write(BinaryWriter writer, Reclamations obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.state)
      ..writeByte(2)
      ..write(obj.formId)
      ..writeByte(3)
      ..write(obj.deviceId)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.formEntry)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.form);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReclamationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reclamations _$ReclamationsFromJson(Map<String, dynamic> json) {
  return Reclamations(
    id: json['id'] as int?,
    state: json['state'] as int?,
    formEntry: json['form_entry'] == null
        ? null
        : FormEntry.fromJson(json['form_entry'] as Map<String, dynamic>),
    user: json['user'] as int?,
    createdAt: json['created_at'] as String?,
    form: json['form'] as String?,
  );
}

Map<String, dynamic> _$ReclamationsToJson(Reclamations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'user': instance.user,
      'form_entry': instance.formEntry,
      'created_at': instance.createdAt,
      'form': instance.form,
    };
