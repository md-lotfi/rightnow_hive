// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_question_hist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResponseQuestionHistAdapter extends TypeAdapter<ResponseQuestionHist> {
  @override
  final int typeId = 103;

  @override
  ResponseQuestionHist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseQuestionHist(
      id: fields[0] as int?,
      label: fields[1] as String?,
      labaleAr: fields[2] as String?,
      fieldSet: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ResponseQuestionHist obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.labaleAr)
      ..writeByte(3)
      ..write(obj.fieldSet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseQuestionHistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseQuestionHist _$ResponseQuestionHistFromJson(
        Map<String, dynamic> json) =>
    ResponseQuestionHist(
      id: json['id'] as int?,
      label: json['label'] as String?,
      labaleAr: json['label_ar'] as String?,
      fieldSet: json['field_set'] as int?,
    );

Map<String, dynamic> _$ResponseQuestionHistToJson(
        ResponseQuestionHist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'label_ar': instance.labaleAr,
      'field_set': instance.fieldSet,
    };
