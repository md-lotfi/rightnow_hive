import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dependent_condition.g.dart';

@JsonSerializable()
@HiveType(typeId: 11)
class DependentCondition {
  @HiveField(0)
  @JsonKey(name: 'id')
  int? id;

  @HiveField(1)
  int? questionId;

  @HiveField(2)
  @JsonKey(name: 'condition')
  int? condition;

  @HiveField(3)
  @JsonKey(name: "is_active")
  bool? isActive;

  @HiveField(4)
  @JsonKey(name: "polymorphic_ctype")
  int? polymorphicCtype;

  @HiveField(5)
  @JsonKey(name: "dependant_question")
  int? dependantQuestion;

  @HiveField(6)
  @JsonKey(name: "branch_question")
  int? branchQuestion;

  @JsonKey(name: "choices")
  List<int>? choices;

  @HiveField(7)
  @JsonKey(name: "value", fromJson: _allToString) //, fromJson: _boolToString
  String? value;

  @HiveField(8)
  @JsonKey(name: "resourcetype")
  String? resourcetype;

  DependentCondition(this.id, this.condition, this.isActive, this.polymorphicCtype, this.dependantQuestion, this.branchQuestion, this.value, this.resourcetype, this.questionId);

  factory DependentCondition.fromJson(Map<String, dynamic> json) => _$DependentConditionFromJson(json);

  Map<String, dynamic> toJson() => _$DependentConditionToJson(this);

  //static int _stringToInt(String number) => number == null ? null : int.parse(number);
  //static String _stringFromInt(int number) => number?.toString();

  //static String? _boolToString(bool? b) => b == null ? null : b.toString();

  static String? _allToString(dynamic b) {
    return b.toString();
  }
}
