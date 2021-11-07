import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multiselect_answer.g.dart';

@JsonSerializable()
@HiveType(typeId: 19)
class MultiSelectAnswer extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? answerId;

  @HiveField(2)
  int? answerHolderId;

  @HiveField(3)
  double? geoHolder;

  @HiveField(4)
  int? selectedId;

  @HiveField(5)
  String? selectedLabel;

  MultiSelectAnswer(this.id, this.answerId, this.answerHolderId, this.selectedId, this.selectedLabel, this.geoHolder);

  MultiSelectAnswer.fill(this.answerHolderId, this.selectedId, this.selectedLabel);

  MultiSelectAnswer.fillGeo(this.answerHolderId, this.geoHolder);

  factory MultiSelectAnswer.fromJson(Map<String, dynamic> json) => _$MultiSelectAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$MultiSelectAnswerToJson(this);

  @override
  String toString() {
    return "";
  }
}
