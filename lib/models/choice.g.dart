// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choice.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChoiceAdapter extends TypeAdapter<Choice> {
  @override
  final int typeId = 9;

  @override
  Choice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Choice(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as bool?,
      fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Choice obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.labelAr)
      ..writeByte(3)
      ..write(obj.isOther)
      ..writeByte(4)
      ..write(obj.questionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
