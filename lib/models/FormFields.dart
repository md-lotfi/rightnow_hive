import 'package:flutter/material.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/models/sub_category.dart';
import 'package:rightnow/models/super_category.dart';
import 'package:rightnow/views/language_switch.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';

part 'FormFields.g.dart';

@JsonSerializable()
@HiveType(typeId: 16)
class FormFields {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? icon;

  @JsonKey(name: 'field_sets')
  List<FieldSet>? fieldSets;

  @JsonKey(name: 'category')
  Category? category;

  @JsonKey(name: 'sub_category')
  SubCategory? subCategory;

  @JsonKey(name: 'super_category')
  SuperCategory? superCategory;

  @HiveField(2)
  @JsonKey(ignore: true)
  int? categoryId;

  @JsonKey(ignore: true)
  AnswerHolder? answerHolder;

  @JsonKey(ignore: true)
  Reclamations? reclamations;

  @JsonKey(name: 'name')
  @HiveField(3)
  String? name;

  @HiveField(4)
  @JsonKey(name: 'name_ar')
  String? nameAr;

  @HiveField(5)
  @JsonKey(name: 'description')
  String? description;

  @HiveField(6)
  @JsonKey(name: 'description_ar')
  String? descriptionAr;

  @HiveField(7)
  @JsonKey(name: 'created_at')
  String? createdAt;

  @HiveField(15)
  @JsonKey(ignore: true)
  int? createdAtTimeStamp;

  @HiveField(8)
  @JsonKey(name: 'is_active')
  bool? isActive;

  @HiveField(9)
  @JsonKey(name: 'is_anonymous')
  bool? isAnonymous;

  @HiveField(10)
  @JsonKey(name: 'active_until')
  String? activeUntil;

  @HiveField(11)
  @JsonKey(name: 'success_page_title')
  String? successPageTitle;

  @HiveField(12)
  @JsonKey(name: 'success_page_body')
  String? successPageBody;

  @HiveField(13)
  @JsonKey(name: 'form_inactive_page_title')
  String? formInactivePageTitle;

  @HiveField(14)
  @JsonKey(name: 'form_inactive_page_body')
  String? formInactivePageBody;

  @HiveField(16)
  @JsonKey(ignore: true)
  int? subCategoryId;

  @HiveField(17)
  @JsonKey(ignore: true)
  int? superCategoryId;

  String getName(String? lang) {
    return (lang == LANGUAGE_FR ? name : nameAr) ?? "";
  }

  String getDescription(String? lang) {
    var r = (lang == LANGUAGE_FR ? description : (lang == null ? description : descriptionAr)) ?? "";
    return r;
  }

  FormFields(
      {this.nameAr,
      this.name,
      this.id,
      this.description,
      this.descriptionAr,
      this.createdAt,
      this.createdAtTimeStamp,
      this.isActive,
      this.activeUntil,
      this.successPageTitle,
      this.successPageBody,
      this.icon,
      this.reclamations,
      this.isAnonymous,
      this.categoryId,
      this.formInactivePageTitle,
      this.formInactivePageBody});

  factory FormFields.fromJson(Map<String, dynamic> json) => _$FormFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$FormFieldsToJson(this);

  /*static Future<Box<FormFields>> _getFormFieldsDb() async {
    return await Hive.openBox<FormFields>('FormFields');
  }

  static Future<List<FormFields>> fetchFormsAny(BuildContext? context, {String? searchFormText}) async {
    var f = await _getFormFieldsDb();
    return f.values
        .where(
            (element) => (searchFormText?.isEmpty ?? true) ? true : (context != null ? element.getName(context.locale.languageCode).toLowerCase().contains(searchFormText?.toLowerCase() ?? "") : true))
        .sorted((a, b) => a.createdAtTimeStamp?.compareTo(b.createdAtTimeStamp ?? 0) ?? 0)
        .toList();
  }

  static Future<List<FormFields>> fetchFormsCategory(int categoryId, BuildContext? context, {String? searchFormText}) async {
    var f = await _getFormFieldsDb();
    return f.values
        .where((element) => element.categoryId == categoryId)
        .where(
            (element) => (searchFormText?.isEmpty ?? true) ? true : (context != null ? element.getName(context.locale.languageCode).toLowerCase().contains(searchFormText?.toLowerCase() ?? "") : true))
        .sorted((a, b) => b.createdAtTimeStamp?.compareTo(a.createdAtTimeStamp ?? 0) ?? 0)
        .toList();
  }

  static Future<List<FormFields>> loadFormsCategoryId(BuildContext? context, int? categoryId, int completed, {String? searchFormTitle}) async {
    late List<FormFields> forms;
    if (categoryId == null)
      forms = await fetchFormsAny(context, searchFormText: searchFormTitle);
    else
      forms = await fetchFormsCategory(categoryId, context, searchFormText: searchFormTitle);
    List<FormFields> tmp = [];
    for (var form in forms) {
      var d = await FieldSet.fetchFields(form.id!);
      form.answerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(form.id!, completed);
      form.reclamations = await getDataBase<FormFieldsDao>().fetchReclamations(form.id ?? -1); //fetchReclamations(form.id!);
      form.category = await getDataBase<FormFieldsDao>().getCategory(form.categoryId ?? -1);
      form.fieldSets = [];
      for (var field in d) {
        form.fieldSets!.add(field);
      }
      tmp.add(form);
    }
    return List.from(tmp);
  }*/
}
