import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branched_links.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class BranchedLinks {
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;

  @HiveField(1)
  int? questionId;

  @HiveField(2)
  @JsonKey(name: "condition")
  String? condition;

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

  BranchedLinks(this.id, this.condition, this.isActive, this.polymorphicCtype, this.dependantQuestion, this.branchQuestion, this.questionId);

  factory BranchedLinks.fromJson(Map<String, dynamic> json) => _$BranchedLinksFromJson(json);

  Map<String, dynamic> toJson() => _$BranchedLinksToJson(this);
}
