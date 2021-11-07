// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUserAdapter extends TypeAdapter<LocalUser> {
  @override
  final int typeId = 18;

  @override
  LocalUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUser(
      fields[2] as String?,
      fields[4] as String?,
      fields[3] as String?,
      fields[5] as String?,
      fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.organization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) {
  return LocalUser(
    json['username'] as String?,
    json['password'] as String?,
    json['email'] as String?,
    json['organization'] as String?,
    json['user'] as int?,
  );
}

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
      'user': instance.user,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'organization': instance.organization,
    };
