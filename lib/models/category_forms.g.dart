// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_forms.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryFormsAdapter extends TypeAdapter<CategoryForms> {
  @override
  final int typeId = 6;

  @override
  CategoryForms read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryForms(
      fields[0] as int?,
      fields[2] as String?,
      fields[4] as String?,
      fields[3] as String?,
      fields[1] as String?,
      fields[5] as int?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryForms obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.nameFr)
      ..writeByte(4)
      ..write(obj.nameAr)
      ..writeByte(5)
      ..write(obj.belongsTo)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryFormsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryForms _$CategoryFormsFromJson(Map<String, dynamic> json) =>
    CategoryForms(
      json['id'] as int?,
      json['name'] as String?,
      json['name_ar'] as String?,
      json['name_fr'] as String?,
      json['icon'] as String?,
      json['belongs_to'] as int?,
      json['created_at'] as String?,
    )
      ..tags = (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList()
      ..forms = (json['forms'] as List<dynamic>?)
          ?.map((e) => FormFields.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CategoryFormsToJson(CategoryForms instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'name_fr': instance.nameFr,
      'name_ar': instance.nameAr,
      'belongs_to': instance.belongsTo,
      'created_at': instance.createdAt,
      'tags': instance.tags,
      'forms': instance.forms,
    };
