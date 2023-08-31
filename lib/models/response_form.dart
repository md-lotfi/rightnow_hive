import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:rightnow/models/response_entry.dart';
import 'package:rightnow/views/language_switch.dart';

part 'response_form.g.dart';

@JsonSerializable()
@HiveType(typeId: 100)
class ResponseForm extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(2)
  @JsonKey(name: 'entries')
  List<ResponseEntry>? entries;

  ResponseForm({
    this.name,
    this.nameAr,
    this.entries,
  });

  String getName(String? lang) {
    //return name ?? "";
    return (lang == LANGUAGE_FR ? name : nameAr) ?? "";
  }

  factory ResponseForm.fromJson(Map<String, dynamic> json) => _$ResponseFormFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseFormToJson(this);
}
