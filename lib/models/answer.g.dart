// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerAdapter extends TypeAdapter<Answer> {
  @override
  final int typeId = 1;

  @override
  Answer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answer(
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as int?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as String?,
      fields[4] as String?,
      fields[3] as int?,
    )..fileKey = fields[8] as int?;
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.qustionId)
      ..writeByte(2)
      ..write(obj.fieldSetId)
      ..writeByte(3)
      ..write(obj.answerHolderId)
      ..writeByte(4)
      ..write(obj.resourcetype)
      ..writeByte(5)
      ..write(obj.answerValue)
      ..writeByte(6)
      ..write(obj.valueExtra)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.fileKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    json['id'] as int?,
    json['question_id'] as int?,
    json['fieldSetId'] as int?,
    json['value'] as String?,
    json['valueExtra'] as String?,
    json['createdAt'] as String?,
    json['resourcetype'] as String?,
    json['answerHolderId'] as int?,
  )
    ..fileKey = json['fileKey'] as int?
    ..choices =
        (json['choices'] as List<dynamic>?)?.map((e) => e as int).toList()
    ..multiSelectAnswer = (json['multiSelectAnswer'] as List<dynamic>?)
        ?.map((e) => MultiSelectAnswer.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'question_id': instance.qustionId,
      'fieldSetId': instance.fieldSetId,
      'answerHolderId': instance.answerHolderId,
      'resourcetype': instance.resourcetype,
      'value': instance.answerValue,
      'valueExtra': instance.valueExtra,
      'createdAt': instance.createdAt,
      'fileKey': instance.fileKey,
      'choices': instance.choices,
      'multiSelectAnswer': instance.multiSelectAnswer,
    };
