import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/models/form_entry.dart';
import 'package:rightnow/models/form_state.dart';

part 'reclamations.g.dart';

@JsonSerializable()
@HiveType(typeId: 22)
class Reclamations {
  @HiveField(0)
  int? id;

  @HiveField(1)
  @JsonKey(name: "state")
  int? state;

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
  String? createdAt;

  @HiveField(7)
  @JsonKey(name: "form")
  String? form;

  Reclamations({this.id, this.state, this.formEntry, this.deviceId, this.user, this.createdAt, this.form});

  factory Reclamations.fromJson(Map<String, dynamic> json) => _$ReclamationsFromJson(json);

  Map<String, dynamic> toJson() => _$ReclamationsToJson(this);
}
