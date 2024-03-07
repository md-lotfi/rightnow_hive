// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FieldSet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FieldSetAdapter extends TypeAdapter<FieldSet> {
  @override
  final int typeId = 14;

  @override
  FieldSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FieldSet(
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as int?,
      fields[6] as int?,
      fields[7] as String?,
      fields[8] as String?,
    )
      ..required = fields[3] as int?
      ..qCounts = fields[4] as int?
      ..qAnswered = fields[5] as int?
      ..description = fields[9] as String?
      ..descriptionAr = fields[10] as String?;
  }

  @override
  void write(BinaryWriter writer, FieldSet obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.form)
      ..writeByte(2)
      ..write(obj.questionsCount)
      ..writeByte(3)
      ..write(obj.required)
      ..writeByte(4)
      ..write(obj.qCounts)
      ..writeByte(5)
      ..write(obj.qAnswered)
      ..writeByte(6)
      ..write(obj.flag)
      ..writeByte(7)
      ..write(obj.title)
      ..writeByte(8)
      ..write(obj.titleAr)
      ..writeByte(9)
      ..write(obj.description)
      ..writeByte(10)
      ..write(obj.descriptionAr);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldSet _$FieldSetFromJson(Map<String, dynamic> json) => FieldSet(
      json['id'] as int?,
      json['form'] as int?,
      json['questions_count'] as int?,
      json['flag'] as int?,
      json['title'] as String?,
      json['title_ar'] as String?,
    )
      ..required = json['required'] as int?
      ..qCounts = json['qCounts'] as int?
      ..qAnswered = json['qAnswered'] as int?
      ..description = json['description'] as String?
      ..descriptionAr = json['description_ar'] as String?
      ..questions = (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FieldSetToJson(FieldSet instance) => <String, dynamic>{
      'id': instance.id,
      'form': instance.form,
      'questions_count': instance.questionsCount,
      'required': instance.required,
      'qCounts': instance.qCounts,
      'qAnswered': instance.qAnswered,
      'flag': instance.flag,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
      'questions': instance.questions,
    };
