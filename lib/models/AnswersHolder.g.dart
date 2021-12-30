// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnswersHolder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerHolderAdapter extends TypeAdapter<AnswerHolder> {
  @override
  final int typeId = 2;

  @override
  AnswerHolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerHolder(
      id: fields[0] as int?,
      formId: fields[1] as int?,
      uploaded: fields[2] as bool?,
      state: fields[8] as int?,
      closed: fields[3] as bool?,
      formTitle: fields[4] as String?,
      completedAt: fields[5] as String?,
      createdAt: fields[6] as String?,
      deviceId: fields[7] as String?,
      webArchived: fields[9] as int?,
    )
      ..completed = fields[11] as bool?
      ..offline = fields[10] as bool?;
  }

  @override
  void write(BinaryWriter writer, AnswerHolder obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.formId)
      ..writeByte(2)
      ..write(obj.uploaded)
      ..writeByte(3)
      ..write(obj.closed)
      ..writeByte(11)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.formTitle)
      ..writeByte(5)
      ..write(obj.completedAt)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.deviceId)
      ..writeByte(8)
      ..write(obj.state)
      ..writeByte(9)
      ..write(obj.webArchived)
      ..writeByte(10)
      ..write(obj.offline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerHolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerHolder _$AnswerHolderFromJson(Map<String, dynamic> json) {
  return AnswerHolder(
    id: json['id'] as int?,
    formId: json['form'] as int?,
    uploaded: json['uploaded'] as bool?,
    closed: json['closed'] as bool?,
    formTitle: json['formTitle'] as String?,
    completedAt: json['completed_at'] as String?,
    createdAt: json['createdAt'] as String?,
    deviceId: json['device_id'] as String?,
  )
    ..completed = json['completed'] as bool?
    ..offline = json['offline'] as bool?
    ..answers = (json['responses'] as List<dynamic>?)
        ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
        .toList()
    ..formFields = json['formFields'] == null
        ? null
        : FormFields.fromJson(json['formFields'] as Map<String, dynamic>)
    ..decisionResponse = json['decisionResponse'] == null
        ? null
        : DecisionResponse.fromJson(
            json['decisionResponse'] as Map<String, dynamic>);
}

Map<String, dynamic> _$AnswerHolderToJson(AnswerHolder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'form': instance.formId,
      'uploaded': instance.uploaded,
      'closed': instance.closed,
      'completed': instance.completed,
      'formTitle': instance.formTitle,
      'completed_at': instance.completedAt,
      'createdAt': instance.createdAt,
      'device_id': instance.deviceId,
      'offline': instance.offline,
      'responses': instance.answers,
      'formFields': instance.formFields,
      'decisionResponse': instance.decisionResponse,
    };
