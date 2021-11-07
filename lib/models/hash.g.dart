// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hash.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HashesAdapter extends TypeAdapter<Hashes> {
  @override
  final int typeId = 17;

  @override
  Hashes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hashes(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hashes obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.hash)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HashesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
