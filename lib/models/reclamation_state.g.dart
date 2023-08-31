// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reclamation_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReclamationStateAdapter extends TypeAdapter<ReclamationState> {
  @override
  final int typeId = 112;

  @override
  ReclamationState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReclamationState(
      id: fields[0] as int?,
      name: fields[1] as String?,
      nameAr: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReclamationState obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.nameAr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReclamationStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReclamationState _$ReclamationStateFromJson(Map<String, dynamic> json) {
  return ReclamationState(
    id: json['id'] as int?,
    name: json['name'] as String?,
    nameAr: json['name_ar'] as String?,
  );
}

Map<String, dynamic> _$ReclamationStateToJson(ReclamationState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'name_ar': instance.nameAr,
    };
