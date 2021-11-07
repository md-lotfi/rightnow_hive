import 'package:hive/hive.dart';

part 'tag.g.dart';

@HiveType(typeId: 24)
class Tag {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? createdAt;

  Tag(this.id, this.name, this.createdAt);

  Tag.fromJson(Map<String, dynamic> json) {
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
  }
}
