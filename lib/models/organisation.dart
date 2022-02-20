import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/views/language_switch.dart';

part 'organisation.g.dart';

@HiveType(typeId: 36)
@JsonSerializable()
class Organisation {
  @HiveField(0)
  @JsonKey(name: 'org_key')
  String? orgKey;

  @HiveField(1)
  @JsonKey(name: 'name')
  String? name;

  @HiveField(2)
  @JsonKey(name: 'logo')
  String? logo;

  @HiveField(3)
  @JsonKey(name: 'icon')
  String? icon;

  Organisation({
    this.orgKey,
    this.name,
    this.logo,
    this.icon,
  });

  factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganisationToJson(this);
}
