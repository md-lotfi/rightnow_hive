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
      state: fields[1] as ReclamationState?,
      formEntry: fields[5] as FormEntry?,
      deviceId: fields[3] as String?,
      user: fields[4] as int?,
      createdAt: fields[6] as Jiffy?,
      formId: fields[2] as int?,
      form: fields[7] as String?,
      formAr: fields[8] as String?,
      formDescription: fields[9] as String?,
      formDescriptionAr: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Reclamations obj) {
    writer
      ..writeByte(11)
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
      ..write(obj.form)
      ..writeByte(8)
      ..write(obj.formAr)
      ..writeByte(9)
      ..write(obj.formDescription)
      ..writeByte(10)
      ..write(obj.formDescriptionAr);
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

Reclamations _$ReclamationsFromJson(Map<String, dynamic> json) => Reclamations(
      id: (json['id'] as num?)?.toInt(),
      state: json['state'] == null
          ? null
          : ReclamationState.fromJson(json['state'] as Map<String, dynamic>),
      formEntry: json['form_entry'] == null
          ? null
          : FormEntry.fromJson(json['form_entry'] as Map<String, dynamic>),
      user: (json['user'] as num?)?.toInt(),
      createdAt:
          const JiffySecondsConverter().fromJson(json['created_at'] as String?),
      form: json['form'] as String?,
      formAr: json['form_ar'] as String?,
      formDescription: json['form_description'] as String?,
      formDescriptionAr: json['form_description_ar'] as String?,
    );

Map<String, dynamic> _$ReclamationsToJson(Reclamations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'user': instance.user,
      'form_entry': instance.formEntry,
      'created_at': const JiffySecondsConverter().toJson(instance.createdAt),
      'form': instance.form,
      'form_ar': instance.formAr,
      'form_description': instance.formDescription,
      'form_description_ar': instance.formDescriptionAr,
    };
