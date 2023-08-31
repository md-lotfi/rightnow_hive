import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/models/choice.dart';

import 'package:rightnow/models/response_question_hist.dart';

part 'response_set.g.dart';

@JsonSerializable()
@HiveType(typeId: 102)
class ResponseSet extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: 'value')
  dynamic value;

  @HiveField(2)
  @JsonKey(name: 'entry')
  Map<String, dynamic>? entry;

  @HiveField(3)
  @JsonKey(name: 'question')
  int? question;

  @HiveField(4)
  @JsonKey(name: 'resourcetype')
  String? resourcetype;

  @HiveField(5)
  @JsonKey(name: 'question_hist')
  ResponseQuestionHist? questionHist;

  @HiveField(6)
  @JsonKey(name: 'type', fromJson: _dynToString)
  String? type;

  @HiveField(7)
  String? url;

  @HiveField(8)
  @JsonKey(name: 'choice_value')
  List<Choice>? choiceValue;

  ResponseSet({
    required this.id,
    required this.value,
    this.entry,
    this.question,
    this.resourcetype,
    this.questionHist,
  });

  Choice? getChoice() {
    if (choiceValue == null || value == null) return null;
    return choiceValue!.firstWhere((element) => element.id == value[0]);
  }

  factory ResponseSet.fromJson(Map<String, dynamic> json) => _$ResponseSetFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseSetToJson(this);
  static String? _dynToString(dynamic b) => b == null ? null : b.toString();
}
