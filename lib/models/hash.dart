import 'package:hive/hive.dart';

part 'hash.g.dart';

@HiveType(typeId: 17)
class Hashes extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? hash;

  @HiveField(2)
  String? type;

  @HiveField(3)
  Hashes(this.id, this.hash, this.type);

  Hashes.fill(this.hash, this.type);

  Hashes.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }

  @override
  String toString() {
    return (this.hash ?? "") + ", " + (this.type ?? "");
  }
}
