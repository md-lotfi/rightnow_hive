// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actualite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actualite _$ActualiteFromJson(Map<String, dynamic> json) => Actualite(
      id: (json['id'] as num?)?.toInt(),
      stateName: json['state_name'] as String?,
      typeName: json['type_name'] as String?,
      state: (json['state'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      title: json['title'] as String?,
      createdAt:
          const JiffySecondsConverter().fromJson(json['created_at'] as String?),
      updatedAt:
          const JiffySecondsConverter().fromJson(json['updated_at'] as String?),
      content: json['content'] as String?,
      image: json['image'] as String?,
      resourceType: json['resourcetype'] as String?,
      description: json['description'] as String?,
      link: json['link'] as String?,
      isImportant: json['is_important'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      contentAr: json['content_ar'] as String?,
      descriptionAr: json['description_ar'] as String?,
      titleAr: json['title_ar'] as String?,
    );

Map<String, dynamic> _$ActualiteToJson(Actualite instance) => <String, dynamic>{
      'id': instance.id,
      'state_name': instance.stateName,
      'type_name': instance.typeName,
      'state': instance.state,
      'type': instance.type,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'is_important': instance.isImportant,
      'thumbnail': instance.thumbnail,
      'link': instance.link,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
      'created_at': const JiffySecondsConverter().toJson(instance.createdAt),
      'updated_at': const JiffySecondsConverter().toJson(instance.updatedAt),
      'content': instance.content,
      'content_ar': instance.contentAr,
      'image': instance.image,
      'resourcetype': instance.resourceType,
    };
