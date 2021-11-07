// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 8;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      fields[0] as int?,
      fields[3] as String?,
      fields[2] as String?,
      fields[1] as String?,
      fields[5] as String?,
    )..superCategoryId = fields[4] as int?;
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.nameFr)
      ..writeByte(3)
      ..write(obj.nameAr)
      ..writeByte(4)
      ..write(obj.superCategoryId)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    json['id'] as int?,
    json['name_ar'] as String?,
    json['name'] as String?,
    json['icon'] as String?,
    json['created_at'] as String?,
  )
    ..belongsTo = json['belongs_to'] == null
        ? null
        : SuperCategory.fromJson(json['belongs_to'] as Map<String, dynamic>)
    ..tags = (json['tags'] as List<dynamic>?)
        ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
        .toList()
    ..subcategories = (json['subcategories'] as List<dynamic>?)
        ?.map((e) => CategoryForms.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.nameFr,
      'name_ar': instance.nameAr,
      'belongs_to': instance.belongsTo,
      'created_at': instance.createdAt,
      'tags': instance.tags,
      'subcategories': instance.subcategories,
    };
