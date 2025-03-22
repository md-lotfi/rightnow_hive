import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/classes/jiffy_seconds_converter.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/form_entry.dart';
import 'package:rightnow/models/form_state.dart';
import 'package:rightnow/models/reclamation_state.dart';
import 'package:rightnow/views/language_switch.dart';

part 'reclamations.g.dart';

@JsonSerializable()
@JiffySecondsConverter()
@HiveType(typeId: 22)
class Reclamations {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "state")
  ReclamationState? state;

  @JsonKey(ignore: true)
  FormFieldsState? formState;

  @HiveField(2)
  @JsonKey(ignore: true)
  int? formId;

  @HiveField(3)
  @JsonKey(ignore: true)
  String? deviceId;

  @HiveField(4)
  @JsonKey(name: "user")
  int? user;

  @HiveField(5)
  @JsonKey(name: "form_entry")
  FormEntry? formEntry;

  @HiveField(6)
  @JsonKey(name: "created_at")
  Jiffy? createdAt;

  @HiveField(7)
  @JsonKey(name: "form")
  String? form;

  @HiveField(8)
  @JsonKey(name: "form_ar")
  String? formAr;

  @HiveField(9)
  @JsonKey(name: "form_description")
  String? formDescription;

  @HiveField(10)
  @JsonKey(name: "form_description_ar")
  String? formDescriptionAr;

  @JsonKey(ignore: true)
  AnswerHolder? localAnswerHolder;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? form : formAr) ?? "";
  }

  String getDescription(String? lang) {
    var r = (lang == LANGUAGE_FR
            ? formDescription
            : (lang == null ? formDescription : formDescriptionAr)) ??
        "";
    return r;
  }

  Reclamations({
    this.id,
    this.state,
    this.formEntry,
    this.deviceId,
    this.user,
    this.createdAt,
    this.formId,
    this.form,
    this.formAr,
    this.formDescription,
    this.formDescriptionAr,
    this.localAnswerHolder,
  });

  factory Reclamations.fromJson(Map<String, dynamic> json) =>
      _$ReclamationsFromJson(json);

  Map<String, dynamic> toJson() => _$ReclamationsToJson(this);
}
