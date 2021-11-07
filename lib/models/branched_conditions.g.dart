// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branched_conditions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchedConditionsAdapter extends TypeAdapter<BranchedConditions> {
  @override
  final int typeId = 4;

  @override
  BranchedConditions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchedConditions(
      fields[0] as int?,
      fields[3] as int?,
      fields[5] as bool?,
      fields[6] as int?,
      fields[7] as int?,
      fields[8] as int?,
      fields[10] as String?,
      fields[1] as int?,
      fields[2] as String?,
      fields[4] as int?,
      (fields[9] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, BranchedConditions obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.conditionName)
      ..writeByte(3)
      ..write(obj.condition)
      ..writeByte(4)
      ..write(obj.precededBy)
      ..writeByte(5)
      ..write(obj.isActive)
      ..writeByte(6)
      ..write(obj.polymorphicCtype)
      ..writeByte(7)
      ..write(obj.dependantQuestion)
      ..writeByte(8)
      ..write(obj.branchQuestion)
      ..writeByte(9)
      ..write(obj.choices)
      ..writeByte(10)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchedConditionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchedConditions _$BranchedConditionsFromJson(Map<String, dynamic> json) {
  return BranchedConditions(
    json['id'] as int?,
    json['condition'] as int?,
    json['is_active'] as bool?,
    json['polymorphic_ctype'] as int?,
    json['dependant_question'] as int?,
    json['branch_question'] as int?,
    BranchedConditions._allToString(json['value']),
    json['questionId'] as int?,
    json['condition_name'] as String?,
    json['preceded_by'] as int?,
    (json['choices'] as List<dynamic>?)?.map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$BranchedConditionsToJson(BranchedConditions instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'condition_name': instance.conditionName,
      'condition': instance.condition,
      'preceded_by': instance.precededBy,
      'is_active': instance.isActive,
      'polymorphic_ctype': instance.polymorphicCtype,
      'dependant_question': instance.dependantQuestion,
      'branch_question': instance.branchQuestion,
      'choices': instance.choices,
      'value': instance.value,
    };
