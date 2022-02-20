// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_saver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileSaverAdapter extends TypeAdapter<FileSaver> {
  @override
  final int typeId = 80;

  @override
  FileSaver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileSaver(
      questionId: fields[0] as int,
      answerHolderId: fields[1] as int,
      name: fields[2] as String,
      file: fields[4] as Uint8List,
      path: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileSaver obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.questionId)
      ..writeByte(1)
      ..write(obj.answerHolderId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.path)
      ..writeByte(4)
      ..write(obj.file);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileSaverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
