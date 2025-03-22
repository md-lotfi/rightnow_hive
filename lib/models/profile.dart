import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/blood_group.dart';
import 'package:rightnow/models/disease.dart';
import 'package:rightnow/models/province.dart';

part 'profile.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 30)
class Profile {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "lastname")
  String? name;

  @HiveField(2)
  String? picture;

  @HiveField(3)
  @JsonKey(name: "updated_mobile")
  bool? updatedMobile;

  @HiveField(4)
  @JsonKey(name: "firstname")
  String? fname;

  @HiveField(5)
  String? email;

  @JsonKey(name: "province_data")
  @HiveField(22)
  Province? provinceData;

  @HiveField(23)
  String? province;

  //@JsonKey(ignore: true)
  //Province? province;

  @HiveField(6)
  int? gender;

  @HiveField(7)
  @JsonKey(name: "birth_date")
  String? birthDate;

  @HiveField(8)
  Jiffy? createdAt;

  @HiveField(9)
  Jiffy? updatedAt;

  @HiveField(10)
  int? user;

  @HiveField(11)
  int? town;

  @HiveField(12)
  double? weight;
  @HiveField(13)
  double? height;
  @HiveField(14)
  @JsonKey(name: "IMC")
  @HiveField(15)
  double? imc;
  @HiveField(16)
  bool? vaccination;

  @HiveField(17)
  @JsonKey(name: "vaccin_dose")
  int? vaccinDose;

  @HiveField(18)
  @JsonKey(name: "is_smoker")
  bool? isSmoker;

  @HiveField(19)
  @JsonKey(name: "is_pregnant")
  bool? isPregnant;

  @HiveField(20)
  @JsonKey(name: "blood_group")
  int? bloodGroupId;

  @JsonKey(ignore: true)
  BloodGroup? bloodGroup;

  @HiveField(21)
  @JsonKey(name: "diseases")
  List<int>? diseasesId;

  @JsonKey(ignore: true)
  List<Disease>? diseases;

  Profile(
    this.id,
    this.name,
    this.picture,
    this.fname,
    this.email,
    this.gender,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.town,
    this.weight,
    this.height,
    this.imc,
    this.vaccination,
    this.bloodGroupId,
    this.diseasesId,
    this.isPregnant,
    this.isSmoker,
    this.vaccinDose,
    this.updatedMobile,
  );

  Profile.fill(this.name, this.fname, this.email, this.gender, this.birthDate,
      this.createdAt, this.updatedAt, this.user, this.town);

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
