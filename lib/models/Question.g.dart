// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 21;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as bool?,
      fields[4] as bool?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as int?,
      fields[8] as String?,
      fields[9] as String?,
      fields[10] as int?,
      fields[11] as int?,
      fields[12] as int?,
      fields[13] as String?,
      fields[14] as String?,
      fields[15] as bool?,
      fields[16] as bool?,
      fields[17] as double?,
      fields[18] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.labelAr)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.activeAlways)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.updated)
      ..writeByte(7)
      ..write(obj.maxLength)
      ..writeByte(8)
      ..write(obj.minValue)
      ..writeByte(9)
      ..write(obj.maxValue)
      ..writeByte(10)
      ..write(obj.polymorphicCtype)
      ..writeByte(11)
      ..write(obj.fieldSet)
      ..writeByte(12)
      ..write(obj.formId)
      ..writeByte(13)
      ..write(obj.resourcetype)
      ..writeByte(14)
      ..write(obj.type)
      ..writeByte(15)
      ..write(obj.customIdentifiers)
      ..writeByte(16)
      ..write(obj.isRequired)
      ..writeByte(17)
      ..write(obj.maxSizeKb)
      ..writeByte(18)
      ..write(obj.minSizeKb);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['id'] as int?,
    json['label'] as String?,
    json['label_ar'] as String?,
    json['is_active'] as bool?,
    json['active_always'] as bool?,
    json['created_at'] as String?,
    json['updated'] as String?,
    json['max_length'] as int?,
    json['min_value'] as String?,
    json['max_value'] as String?,
    json['polymorphic_ctype'] as int?,
    json['fieldSet'] as int?,
    json['formId'] as int?,
    json['resourcetype'] as String?,
    Question._dynToString(json['type']),
    json['custom_identifiers'] as bool?,
    json['is_required'] as bool?,
    (json['max_size_kb'] as num?)?.toDouble(),
    (json['min_size_kb'] as num?)?.toDouble(),
  )
    ..choices = (json['choices'] as List<dynamic>?)
        ?.map((e) => Choice.fromJson(e as Map<String, dynamic>))
        .toList()
    ..depandantConditions = (json['dependant_conditions'] as List<dynamic>?)
        ?.map((e) => DependentCondition.fromJson(e as Map<String, dynamic>))
        .toList()
    ..branchedLinks = (json['branched_links'] as List<dynamic>?)
        ?.map((e) => BranchedLinks.fromJson(e as Map<String, dynamic>))
        .toList()
    ..branchedConditions = (json['branched_conditions'] as List<dynamic>?)
        ?.map((e) => BranchedConditions.fromJson(e as Map<String, dynamic>))
        .toList()
    ..allowedTypes = (json['allowed_types'] as List<dynamic>?)
        ?.map((e) => AllowedTypes.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'label_ar': instance.labelAr,
      'is_active': instance.isActive,
      'active_always': instance.activeAlways,
      'created_at': instance.createdAt,
      'updated': instance.updated,
      'max_length': instance.maxLength,
      'min_value': instance.minValue,
      'max_value': instance.maxValue,
      'choices': instance.choices,
      'dependant_conditions': instance.depandantConditions,
      'branched_links': instance.branchedLinks,
      'branched_conditions': instance.branchedConditions,
      'allowed_types': instance.allowedTypes,
      'polymorphic_ctype': instance.polymorphicCtype,
      'fieldSet': instance.fieldSet,
      'formId': instance.formId,
      'resourcetype': instance.resourcetype,
      'type': instance.type,
      'custom_identifiers': instance.customIdentifiers,
      'is_required': instance.isRequired,
      'max_size_kb': instance.maxSizeKb,
      'min_size_kb': instance.minSizeKb,
    };
