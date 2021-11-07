import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'province.g.dart';

@JsonSerializable()
@HiveType(typeId: 28)
class Province {
  @HiveField(0)
  String id;

  @HiveField(1)
  String code;

  @HiveField(2)
  @JsonKey(name: "name_fr")
  String nameFr;

  @HiveField(3)
  @JsonKey(name: "name_ar")
  String nameAr;

  String getName(String? lang) {
    return lang == LANGUAGE_FR ? nameFr : (lang == null ? nameFr : nameAr);
  }

  Province(this.id, this.code, this.nameFr, this.nameAr);

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);

  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
