// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ErrorModelAdapter extends TypeAdapter<ErrorModel> {
  @override
  final int typeId = 13;

  @override
  ErrorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ErrorModel(
      fields[0] as int?,
      fields[1] as int?,
      fields[2] as int?,
      fields[3] as int?,
      fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ErrorModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.questionId)
      ..writeByte(2)
      ..write(obj.fieldSetId)
      ..writeByte(3)
      ..write(obj.formId)
      ..writeByte(4)
      ..write(obj.errorMessage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
