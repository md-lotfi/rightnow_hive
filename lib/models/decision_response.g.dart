// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DecisionResponseAdapter extends TypeAdapter<DecisionResponse> {
  @override
  final int typeId = 10;

  @override
  DecisionResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DecisionResponse(
      id: fields[0] as int?,
      title: fields[2] as String?,
      text: fields[3] as String?,
      image: fields[6] as String?,
      url: fields[7] as String?,
      sound: fields[8] as String?,
      textActive: fields[9] as bool?,
      imageActive: fields[10] as bool?,
      urlActive: fields[11] as bool?,
      soundActive: fields[12] as bool?,
      defaultResponse: fields[13] as bool?,
      algorithme: fields[14] as int?,
      answerHolderId: fields[1] as int?,
      textAr: fields[5] as String?,
      titleAr: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DecisionResponse obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.answerHolderId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.titleAr)
      ..writeByte(5)
      ..write(obj.textAr)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.url)
      ..writeByte(8)
      ..write(obj.sound)
      ..writeByte(9)
      ..write(obj.textActive)
      ..writeByte(10)
      ..write(obj.imageActive)
      ..writeByte(11)
      ..write(obj.urlActive)
      ..writeByte(12)
      ..write(obj.soundActive)
      ..writeByte(13)
      ..write(obj.defaultResponse)
      ..writeByte(14)
      ..write(obj.algorithme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecisionResponse _$DecisionResponseFromJson(Map<String, dynamic> json) =>
    DecisionResponse(
      id: json['id'] as int?,
      title: json['title'] as String?,
      text: json['text'] as String?,
      image: json['image'] as String?,
      url: json['url'] as String?,
      sound: json['sound'] as String?,
      textActive: json['text_active'] as bool?,
      imageActive: json['image_active'] as bool?,
      urlActive: json['url_active'] as bool?,
      soundActive: json['sound_active'] as bool?,
      defaultResponse: json['default'] as bool?,
      algorithme: json['algorithme'] as int?,
      answerHolderId: json['answerHolderId'] as int?,
      textAr: json['text_ar'] as String?,
      titleAr: json['title_ar'] as String?,
    );

Map<String, dynamic> _$DecisionResponseToJson(DecisionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answerHolderId': instance.answerHolderId,
      'title': instance.title,
      'text': instance.text,
      'title_ar': instance.titleAr,
      'text_ar': instance.textAr,
      'image': instance.image,
      'url': instance.url,
      'sound': instance.sound,
      'text_active': instance.textActive,
      'image_active': instance.imageActive,
      'url_active': instance.urlActive,
      'sound_active': instance.soundActive,
      'default': instance.defaultResponse,
      'algorithme': instance.algorithme,
    };
