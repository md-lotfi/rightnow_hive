// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_middle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryMiddleAdapter extends TypeAdapter<CategoryMiddle> {
  @override
  final int typeId = 7;

  @override
  CategoryMiddle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryMiddle(
      fields[0] as int?,
      fields[4] as String?,
      fields[3] as String?,
      fields[2] as String?,
      fields[1] as String?,
      fields[5] as int?,
      fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryMiddle obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.nameFr)
      ..writeByte(3)
      ..write(obj.nameAr)
      ..writeByte(4)
      ..write(obj.name)
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
      other is CategoryMiddleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryMiddle _$CategoryMiddleFromJson(Map<String, dynamic> json) =>
    CategoryMiddle(
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
      ..subcategories = (json['subcategories'] as List<dynamic>?)
          ?.map((e) => CategoryForms.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CategoryMiddleToJson(CategoryMiddle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name_fr': instance.nameFr,
      'name_ar': instance.nameAr,
      'name': instance.name,
      'belongs_to': instance.belongsTo,
      'created_at': instance.createdAt,
      'tags': instance.tags,
      'subcategories': instance.subcategories,
    };
