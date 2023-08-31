// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_buttons.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeButtonsAdapter extends TypeAdapter<HomeButtons> {
  @override
  final int typeId = 26;

  @override
  HomeButtons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeButtons(
      fields[0] as int?,
      fields[2] as String?,
      fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeButtons obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeButtonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
