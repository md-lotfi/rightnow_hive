// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileAdapter extends TypeAdapter<Profile> {
  @override
  final int typeId = 30;

  @override
  Profile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profile(
      fields[0] as int?,
      fields[1] as String?,
      fields[2] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as int?,
      fields[7] as String?,
      fields[8] as Jiffy?,
      fields[9] as Jiffy?,
      fields[10] as int?,
      fields[11] as int?,
      fields[12] as double?,
      fields[13] as double?,
      fields[14] as double?,
      fields[16] as bool?,
      fields[20] as int?,
      (fields[21] as List?)?.cast<int>(),
      fields[19] as bool?,
      fields[18] as bool?,
      fields[17] as int?,
      fields[3] as bool?,
    )
      ..provinceData = fields[22] as Province?
      ..province = fields[23] as String?;
  }

  @override
  void write(BinaryWriter writer, Profile obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.picture)
      ..writeByte(3)
      ..write(obj.updatedMobile)
      ..writeByte(4)
      ..write(obj.fname)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(22)
      ..write(obj.provinceData)
      ..writeByte(23)
      ..write(obj.province)
      ..writeByte(6)
      ..write(obj.gender)
      ..writeByte(7)
      ..write(obj.birthDate)
      ..writeByte(8)
      ..write(obj.createdAt)
      ..writeByte(9)
      ..write(obj.updatedAt)
      ..writeByte(10)
      ..write(obj.user)
      ..writeByte(11)
      ..write(obj.town)
      ..writeByte(12)
      ..write(obj.weight)
      ..writeByte(13)
      ..write(obj.height)
      ..writeByte(14)
      ..write(obj.imc)
      ..writeByte(16)
      ..write(obj.vaccination)
      ..writeByte(17)
      ..write(obj.vaccinDose)
      ..writeByte(18)
      ..write(obj.isSmoker)
      ..writeByte(19)
      ..write(obj.isPregnant)
      ..writeByte(20)
      ..write(obj.bloodGroupId)
      ..writeByte(21)
      ..write(obj.diseasesId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      (json['id'] as num?)?.toInt(),
      json['lastname'] as String?,
      json['picture'] as String?,
      json['firstname'] as String?,
      json['email'] as String?,
      (json['gender'] as num?)?.toInt(),
      json['birth_date'] as String?,
      const JiffySecondsConverter().fromJson(json['createdAt'] as String?),
      const JiffySecondsConverter().fromJson(json['updatedAt'] as String?),
      (json['user'] as num?)?.toInt(),
      (json['town'] as num?)?.toInt(),
      (json['weight'] as num?)?.toDouble(),
      (json['height'] as num?)?.toDouble(),
      (json['IMC'] as num?)?.toDouble(),
      json['vaccination'] as bool?,
      (json['blood_group'] as num?)?.toInt(),
      (json['diseases'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      json['is_pregnant'] as bool?,
      json['is_smoker'] as bool?,
      (json['vaccin_dose'] as num?)?.toInt(),
      json['updated_mobile'] as bool?,
    )
      ..provinceData = json['province_data'] == null
          ? null
          : Province.fromJson(json['province_data'] as Map<String, dynamic>)
      ..province = json['province'] as String?;

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'id': instance.id,
      'lastname': instance.name,
      'picture': instance.picture,
      'updated_mobile': instance.updatedMobile,
      'firstname': instance.fname,
      'email': instance.email,
      'province_data': instance.provinceData,
      'province': instance.province,
      'gender': instance.gender,
      'birth_date': instance.birthDate,
      'createdAt': const JiffySecondsConverter().toJson(instance.createdAt),
      'updatedAt': const JiffySecondsConverter().toJson(instance.updatedAt),
      'user': instance.user,
      'town': instance.town,
      'weight': instance.weight,
      'height': instance.height,
      'IMC': instance.imc,
      'vaccination': instance.vaccination,
      'vaccin_dose': instance.vaccinDose,
      'is_smoker': instance.isSmoker,
      'is_pregnant': instance.isPregnant,
      'blood_group': instance.bloodGroupId,
      'diseases': instance.diseasesId,
    };
