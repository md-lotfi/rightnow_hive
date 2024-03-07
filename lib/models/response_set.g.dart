// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_set.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseSetAdapter extends TypeAdapter<ResponseSet> {
  @override
  final int typeId = 102;

  @override
  ResponseSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseSet(
      id: fields[0] as int?,
      value: fields[1] as dynamic,
      entry: (fields[2] as Map?)?.cast<String, dynamic>(),
      question: fields[3] as int?,
      resourcetype: fields[4] as String?,
      questionHist: fields[5] as ResponseQuestionHist?,
    )
      ..type = fields[6] as String?
      ..url = fields[7] as String?
      ..choiceValue = (fields[8] as List?)?.cast<Choice>();
  }

  @override
  void write(BinaryWriter writer, ResponseSet obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.entry)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.resourcetype)
      ..writeByte(5)
      ..write(obj.questionHist)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.choiceValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseSet _$ResponseSetFromJson(Map<String, dynamic> json) => ResponseSet(
      id: json['id'] as int?,
      value: json['value'],
      entry: json['entry'] as Map<String, dynamic>?,
      question: json['question'] as int?,
      resourcetype: json['resourcetype'] as String?,
      questionHist: json['question_hist'] == null
          ? null
          : ResponseQuestionHist.fromJson(
              json['question_hist'] as Map<String, dynamic>),
    )
      ..type = ResponseSet._dynToString(json['type'])
      ..url = json['url'] as String?
      ..choiceValue = (json['choice_value'] as List<dynamic>?)
          ?.map((e) => Choice.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResponseSetToJson(ResponseSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'entry': instance.entry,
      'question': instance.question,
      'resourcetype': instance.resourcetype,
      'question_hist': instance.questionHist,
      'type': instance.type,
      'url': instance.url,
      'choice_value': instance.choiceValue,
    };
