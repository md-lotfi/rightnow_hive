// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FormFields.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormFieldsAdapter extends TypeAdapter<FormFields> {
  @override
  final int typeId = 16;

  @override
  FormFields read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FormFields(
      nameAr: fields[4] as String?,
      name: fields[3] as String?,
      id: fields[0] as int?,
      description: fields[5] as String?,
      descriptionAr: fields[6] as String?,
      createdAt: fields[7] as String?,
      createdAtTimeStamp: fields[15] as int?,
      isActive: fields[8] as bool?,
      activeUntil: fields[10] as String?,
      successPageTitle: fields[11] as String?,
      successPageBody: fields[12] as String?,
      icon: fields[1] as String?,
      isAnonymous: fields[9] as bool?,
      categoryId: fields[2] as int?,
      formInactivePageTitle: fields[13] as String?,
      formInactivePageBody: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FormFields obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.nameAr)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.descriptionAr)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.createdAtTimeStamp)
      ..writeByte(8)
      ..write(obj.isActive)
      ..writeByte(9)
      ..write(obj.isAnonymous)
      ..writeByte(10)
      ..write(obj.activeUntil)
      ..writeByte(11)
      ..write(obj.successPageTitle)
      ..writeByte(12)
      ..write(obj.successPageBody)
      ..writeByte(13)
      ..write(obj.formInactivePageTitle)
      ..writeByte(14)
      ..write(obj.formInactivePageBody);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFieldsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormFields _$FormFieldsFromJson(Map<String, dynamic> json) {
  return FormFields(
    nameAr: json['name_ar'] as String?,
    name: json['name'] as String?,
    id: json['id'] as int?,
    description: json['description'] as String?,
    descriptionAr: json['description_ar'] as String?,
    createdAt: json['created_at'] as String?,
    isActive: json['is_active'] as bool?,
    activeUntil: json['active_until'] as String?,
    successPageTitle: json['success_page_title'] as String?,
    successPageBody: json['success_page_body'] as String?,
    icon: json['icon'] as String?,
    isAnonymous: json['is_anonymous'] as bool?,
    formInactivePageTitle: json['form_inactive_page_title'] as String?,
    formInactivePageBody: json['form_inactive_page_body'] as String?,
  )
    ..fieldSets = (json['field_sets'] as List<dynamic>?)
        ?.map((e) => FieldSet.fromJson(e as Map<String, dynamic>))
        .toList()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>);
}

Map<String, dynamic> _$FormFieldsToJson(FormFields instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'field_sets': instance.fieldSets,
      'category': instance.category,
      'name': instance.name,
      'name_ar': instance.nameAr,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
      'created_at': instance.createdAt,
      'is_active': instance.isActive,
      'is_anonymous': instance.isAnonymous,
      'active_until': instance.activeUntil,
      'success_page_title': instance.successPageTitle,
      'success_page_body': instance.successPageBody,
      'form_inactive_page_title': instance.formInactivePageTitle,
      'form_inactive_page_body': instance.formInactivePageBody,
    };
