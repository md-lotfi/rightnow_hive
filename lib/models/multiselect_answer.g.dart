// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiselect_answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiSelectAnswerAdapter extends TypeAdapter<MultiSelectAnswer> {
  @override
  final int typeId = 19;

  @override
  MultiSelectAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiSelectAnswer(
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as int?,
      fields[4] as int?,
      fields[5] as String?,
      fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MultiSelectAnswer obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.answerId)
      ..writeByte(2)
      ..write(obj.answerHolderId)
      ..writeByte(3)
      ..write(obj.geoHolder)
      ..writeByte(4)
      ..write(obj.selectedId)
      ..writeByte(5)
      ..write(obj.selectedLabel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiSelectAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiSelectAnswer _$MultiSelectAnswerFromJson(Map<String, dynamic> json) =>
    MultiSelectAnswer(
      (json['id'] as num?)?.toInt(),
      (json['answerId'] as num?)?.toInt(),
      (json['answerHolderId'] as num?)?.toInt(),
      (json['selectedId'] as num?)?.toInt(),
      json['selectedLabel'] as String?,
      (json['geoHolder'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MultiSelectAnswerToJson(MultiSelectAnswer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answerId': instance.answerId,
      'answerHolderId': instance.answerHolderId,
      'geoHolder': instance.geoHolder,
      'selectedId': instance.selectedId,
      'selectedLabel': instance.selectedLabel,
    };
