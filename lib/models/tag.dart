import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';

part 'tag.g.dart';

@HiveType(typeId: 24)
@JsonSerializable()
@JiffySecondsConverter()
class Tag {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  Jiffy? createdAt;

  Tag(this.id, this.name, this.createdAt);

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);

  /*Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }*/
}
