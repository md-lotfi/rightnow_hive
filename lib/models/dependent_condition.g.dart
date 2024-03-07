// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent_condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DependentConditionAdapter extends TypeAdapter<DependentCondition> {
  @override
  final int typeId = 11;

  @override
  DependentCondition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DependentCondition(
      fields[0] as int?,
      fields[2] as int?,
      fields[3] as bool?,
      fields[4] as int?,
      fields[5] as int?,
      fields[6] as int?,
      fields[7] as String?,
      fields[8] as String?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DependentCondition obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.isActive)
      ..writeByte(4)
      ..write(obj.polymorphicCtype)
      ..writeByte(5)
      ..write(obj.dependantQuestion)
      ..writeByte(6)
      ..write(obj.branchQuestion)
      ..writeByte(7)
      ..write(obj.value)
      ..writeByte(8)
      ..write(obj.resourcetype);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DependentConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DependentCondition _$DependentConditionFromJson(Map<String, dynamic> json) =>
    DependentCondition(
      json['id'] as int?,
      json['condition'] as int?,
      json['is_active'] as bool?,
      json['polymorphic_ctype'] as int?,
      json['dependant_question'] as int?,
      json['branch_question'] as int?,
      DependentCondition._allToString(json['value']),
      json['resourcetype'] as String?,
      json['questionId'] as int?,
    )..choices =
        (json['choices'] as List<dynamic>?)?.map((e) => e as int).toList();

Map<String, dynamic> _$DependentConditionToJson(DependentCondition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'condition': instance.condition,
      'is_active': instance.isActive,
      'polymorphic_ctype': instance.polymorphicCtype,
      'dependant_question': instance.dependantQuestion,
      'branch_question': instance.branchQuestion,
      'choices': instance.choices,
      'value': instance.value,
      'resourcetype': instance.resourcetype,
    };
