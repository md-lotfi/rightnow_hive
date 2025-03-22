import 'package:jiffy/jiffy.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/allowed_types.dart';
import 'package:rightnow/models/branched_conditions.dart';
import 'package:rightnow/models/branched_links.dart';
import 'package:rightnow/models/choice.dart';
import 'package:rightnow/models/dependent_condition.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/views/language_switch.dart';

part 'Question.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 21)
class Question {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? label;

  @HiveField(2)
  @JsonKey(name: 'label_ar')
  String? labelAr;

  @HiveField(3)
  @JsonKey(name: 'is_active')
  bool? isActive;

  @HiveField(4)
  @JsonKey(name: 'active_always')
  bool? activeAlways;

  @HiveField(5)
  @JsonKey(name: 'created_at')
  Jiffy? createdAt;

  @HiveField(6)
  Jiffy? updated;

  @HiveField(7)
  @JsonKey(name: 'max_length')
  int? maxLength;

  @HiveField(8)
  @JsonKey(name: 'min_value')
  String? minValue;

  @HiveField(9)
  @JsonKey(name: 'max_value')
  String? maxValue;

  List<Choice>? choices;

  int createdAtTimeStamp() {
    return (createdAt ?? Jiffy.now()).microsecondsSinceEpoch;
  }

  @JsonKey(name: 'dependant_conditions')
  List<DependentCondition>? depandantConditions;

  @JsonKey(name: 'branched_links')
  List<BranchedLinks>? branchedLinks;

  @JsonKey(name: 'branched_conditions')
  List<BranchedConditions>? branchedConditions;

  @JsonKey(name: 'allowed_types')
  List<AllowedTypes>? allowedTypes;

  @HiveField(10)
  @JsonKey(name: 'polymorphic_ctype')
  int? polymorphicCtype;

  @HiveField(11)
  int? fieldSet;

  @HiveField(12)
  int? formId;

  @HiveField(13)
  String? resourcetype;

  @HiveField(14)
  @JsonKey(name: 'type', fromJson: _dynToString)
  String? type;

  @HiveField(15)
  @JsonKey(name: 'custom_identifiers')
  bool? customIdentifiers;

  @HiveField(16)
  @JsonKey(name: 'is_required')
  bool? isRequired;

  @HiveField(17)
  @JsonKey(name: 'max_size_kb')
  double? maxSizeKb;

  @HiveField(18)
  @JsonKey(name: 'min_size_kb')
  double? minSizeKb;

  @HiveField(19)
  String? file;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? label : labelAr) ?? "";
  }

  Question(
      this.id,
      this.label,
      this.labelAr,
      this.isActive,
      this.activeAlways,
      this.createdAt,
      this.updated,
      this.maxLength,
      this.minValue,
      this.maxValue,
      this.polymorphicCtype,
      this.fieldSet,
      this.formId,
      this.file,
      this.resourcetype,
      this.type,
      this.customIdentifiers,
      this.isRequired,
      this.maxSizeKb,
      this.minSizeKb);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  static String? _dynToString(dynamic b) => b == null ? null : b.toString();
}
