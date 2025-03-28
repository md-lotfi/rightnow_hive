import 'package:jiffy/jiffy.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/answer.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/models/decision_response.dart';

part 'AnswersHolder.g.dart';

const WEB_ARCHIVED = 1;
const LOCAL_ARCHIVED = 0;

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 2)
class AnswerHolder extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'form')
  int? formId;

  @HiveField(2)
  bool? uploaded = false;

  @HiveField(3)
  bool? closed = false;

  @HiveField(11)
  bool? completed = false;

  @HiveField(4)
  String? formTitle;

  @HiveField(5)
  @JsonKey(name: 'completed_at')
  Jiffy? completedAt;

  @HiveField(6)
  Jiffy? createdAt;

  @HiveField(7)
  @JsonKey(name: 'device_id')
  String? deviceId;

  @HiveField(8)
  @JsonKey(ignore: true)
  int? state;

  @HiveField(9)
  @JsonKey(ignore: true)
  int? webArchived;

  @HiveField(10)
  bool? offline = false;

  @JsonKey(name: 'responses')
  List<Answer>? answers;

  FormFields? formFields;

  DecisionResponse? decisionResponse;

  int createdAtTimeStamp() {
    return (createdAt ?? Jiffy.now()).microsecondsSinceEpoch;
  }

  AnswerHolder(
      {this.id,
      this.formId,
      this.uploaded,
      this.state,
      this.closed,
      this.formTitle,
      this.completedAt,
      this.createdAt,
      this.deviceId,
      this.webArchived});

  AnswerHolder.fill(this.formId, this.uploaded, this.closed, this.formTitle,
      this.completedAt, this.createdAt, this.deviceId, this.webArchived);

  factory AnswerHolder.fromJson(Map<String, dynamic> json) =>
      _$AnswerHolderFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerHolderToJson(this);

  @override
  String toString() {
    return "";
  }
}
