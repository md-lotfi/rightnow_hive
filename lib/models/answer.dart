import 'package:jiffy/jiffy.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'answer.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 1)
class Answer extends HiveObject {
  @HiveField(0)
  int? id;

  @JsonKey(name: 'question_id')
  @HiveField(1)
  int? qustionId;

  @HiveField(2)
  int? fieldSetId;

  @JsonKey(ignore: true)
  Question? question;

  @HiveField(3)
  int? answerHolderId;

  @HiveField(4)
  String? resourcetype;

  @HiveField(5)
  @JsonKey(name: 'value')
  String? answerValue;

  @HiveField(6)
  String? valueExtra;

  @HiveField(7)
  Jiffy? createdAt;

  @HiveField(8)
  int? fileKey;

  List<int>? choices;

  List<MultiSelectAnswer>? multiSelectAnswer;

  Answer(this.id, this.qustionId, this.fieldSetId, this.answerValue,
      this.valueExtra, this.createdAt, this.resourcetype, this.answerHolderId);

  Answer.fill(
      this.qustionId,
      this.fieldSetId,
      this.answerValue,
      this.valueExtra,
      this.createdAt,
      this.resourcetype,
      this.answerHolderId,
      this.multiSelectAnswer,
      {this.choices,
      this.question,
      this.fileKey});

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  String toString() {
    return "";
  }
}
