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
    )..groups = (fields[6] as List?)?.cast<UserGroup>();
  }

  @override
  void write(BinaryWriter writer, LocalUser obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.organization)
      ..writeByte(6)
      ..write(obj.groups);
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

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
      json['username'] as String?,
      json['password'] as String?,
      json['email'] as String?,
      json['organization'] as String?,
      json['user'] as int?,
    )..groups = (json['groups'] as List<dynamic>?)
        ?.map((e) => UserGroup.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
      'user': instance.user,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'organization': instance.organization,
      'groups': instance.groups,
    };
