import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branched_conditions.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class BranchedConditions {
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;

  @HiveField(1)
  int? questionId;

  @HiveField(2)
  @JsonKey(name: "condition_name")
  String? conditionName;

  @HiveField(3)
  @JsonKey(name: "condition")
  int? condition;

  @HiveField(4)
  @JsonKey(name: "preceded_by")
  int? precededBy;

  @HiveField(5)
  @JsonKey(name: "is_active")
  bool? isActive;

  @HiveField(6)
  @JsonKey(name: "polymorphic_ctype")
  int? polymorphicCtype;

  @HiveField(7)
  @JsonKey(name: "dependant_question")
  int? dependantQuestion;

  @HiveField(8)
  @JsonKey(name: "branch_question")
  int? branchQuestion;

  @HiveField(9)
  @JsonKey(name: "choices")
  //@ignore
  List<int>? choices;

  @HiveField(10)
  @JsonKey(name: "value", fromJson: _allToString)
  String? value;

  BranchedConditions(
    this.id,
    this.condition,
    this.isActive,
    this.polymorphicCtype,
    this.dependantQuestion,
    this.branchQuestion,
    this.value,
    this.questionId,
    this.conditionName,
    this.precededBy,
    this.choices,
  );

  factory BranchedConditions.fromJson(Map<String, dynamic> json) => _$BranchedConditionsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchedConditionsToJson(this);

  //static String? _boolToString(bool? b) => b == null ? null : b.toString();
  static String? _allToString(dynamic b) {
    return b.toString();
  }
}
