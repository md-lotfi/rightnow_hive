// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branched_links.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BranchedLinksAdapter extends TypeAdapter<BranchedLinks> {
  @override
  final int typeId = 5;

  @override
  BranchedLinks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BranchedLinks(
      fields[0] as int?,
      fields[2] as String?,
      fields[3] as bool?,
      fields[4] as int?,
      fields[5] as int?,
      fields[6] as int?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BranchedLinks obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.branchQuestion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchedLinksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchedLinks _$BranchedLinksFromJson(Map<String, dynamic> json) {
  return BranchedLinks(
    json['id'] as int?,
    json['condition'] as String?,
    json['is_active'] as bool?,
    json['polymorphic_ctype'] as int?,
    json['dependant_question'] as int?,
    json['branch_question'] as int?,
    json['questionId'] as int?,
  );
}

Map<String, dynamic> _$BranchedLinksToJson(BranchedLinks instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionId': instance.questionId,
      'condition': instance.condition,
      'is_active': instance.isActive,
      'polymorphic_ctype': instance.polymorphicCtype,
      'dependant_question': instance.dependantQuestion,
      'branch_question': instance.branchQuestion,
    };
