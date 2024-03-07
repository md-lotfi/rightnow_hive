// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubCategoryAdapter extends TypeAdapter<SubCategory> {
  @override
  final int typeId = 110;

  @override
  SubCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubCategory(
      fields[0] as int?,
      fields[3] as String?,
      fields[2] as String?,
      fields[1] as String?,
      fields[5] as String?,
    )
      ..superCategoryId = fields[4] as int?
      ..belongsTo = fields[7] as Category?
      ..categoryId = fields[8] as int?;
  }

  @override
  void write(BinaryWriter writer, SubCategory obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.belongsTo)
      ..writeByte(8)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) => SubCategory(
      json['id'] as int?,
      json['name_ar'] as String?,
      json['name'] as String?,
      json['icon'] as String?,
      json['created_at'] as String?,
    )
      ..tags = (json['tags'] as List<dynamic>?)
          ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList()
      ..belongsTo = json['belongs_to'] == null
          ? null
          : Category.fromJson(json['belongs_to'] as Map<String, dynamic>)
      ..categoryId = json['categoryId'] as int?
      ..subcategories = (json['subcategories'] as List<dynamic>?)
          ?.map((e) => CategoryForms.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.nameFr,
      'name_ar': instance.nameAr,
      'created_at': instance.createdAt,
      'tags': instance.tags,
      'belongs_to': instance.belongsTo,
      'categoryId': instance.categoryId,
      'subcategories': instance.subcategories,
    };
