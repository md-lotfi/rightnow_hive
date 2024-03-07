import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FieldSetsDao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/hash.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/super_category.dart';

class FormFieldsDao extends FieldSetsDao {
  Future<Box<FormFields>> getFormFieldsDb() async {
    return await Hive.openBox<FormFields>('FormFields');
  }

  //@Query("select * from FormFields where id = :formId limit 1")
  Future<FormFields?> fetchForms(int formId) async {
    var f = await getFormFieldsDb();
    return f.values.firstWhereOrNull((element) => element.id == formId);
  }

  //@Query("select * from FormFields where nameFr like :keyword")
  Future<List<FormFields>> searchForms(String keyword) async {
    var f = await getFormFieldsDb();
    return f.values.where((element) => element.name?.contains(keyword) ?? false).toList();
  }

  //@Query("select * from FormFields where categoryId = :categoryId")
  Future<List<FormFields>> fetchFormsCategory(int categoryId, BuildContext? context, {String? searchFormText}) async {
    var f = await getFormFieldsDb();
    return f.values
        .where((element) => element.categoryId == categoryId)
        .where(
            (element) => (searchFormText?.isEmpty ?? true) ? true : (context != null ? element.getName(context.locale.languageCode).toLowerCase().contains(searchFormText?.toLowerCase() ?? "") : true))
        .sorted((a, b) => b.createdAtTimeStamp?.compareTo(a.createdAtTimeStamp ?? 0) ?? 0)
        .toList();
  }

  //int subCategoryId
  Future<List<FormFields>> fetchFormsAnyCategory(dynamic category, BuildContext? context, {String? searchFormText}) async {
    var f = await getFormFieldsDb();
    return f.values
        .where((element) => ((category is SuperCategory)
            ? element.superCategoryId == category.id
            : (category is Category)
                ? element.categoryId == category.id
                : element.subCategoryId == category.id))
        .where(
            (element) => (searchFormText?.isEmpty ?? true) ? true : (context != null ? element.getName(context.locale.languageCode).toLowerCase().contains(searchFormText?.toLowerCase() ?? "") : true))
        .sorted((a, b) => b.createdAtTimeStamp?.compareTo(a.createdAtTimeStamp ?? 0) ?? 0)
        .toList();
  }

  //@Query("select * from FormFields")
  Future<List<FormFields>> fetchFormsAny(BuildContext? context, {String? searchFormText, int? completed}) async {
    var f = await getFormFieldsDb();
    return f.values
        .where((element) {
          return (searchFormText?.isEmpty ?? true) ? true : (context != null ? element.getName(context.locale.languageCode).toLowerCase().contains(searchFormText?.toLowerCase() ?? "") : true);
        })
        .sorted((a, b) => a.createdAtTimeStamp?.compareTo(b.createdAtTimeStamp ?? 0) ?? 0)
        .toList();
  }

  Future<void> removeAllFormsFields() async {
    var f = await getFormFieldsDb();
    await f.clear();
  }

  Future<void> insertForms(List<FormFields> forms) async {
    var f = await getFormFieldsDb();
    for (FormFields form in forms) {
      if (f.values.firstWhereOrNull((element) => element.id == form.id) == null) await f.add(form);
    }
  }

  Future<List<FormFields>> loadFormsCategoryId(BuildContext? context, int? categoryId, int completed, {String? searchFormTitle}) async {
    late List<FormFields> forms;
    if (categoryId == null)
      forms = await fetchFormsAny(context, searchFormText: searchFormTitle);
    else
      forms = await fetchFormsCategory(categoryId, context, searchFormText: searchFormTitle);
    List<FormFields> tmp = [];
    for (var form in forms) {
      var d = await fetchFields(form.id!);
      form.answerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(form.id!, completed);
      if (((form.answerHolder?.completed ?? false) && completed == HOLDER_COMPLETED) ||
          (!(form.answerHolder?.completed ?? false) && completed == HOLDER_NOT_COMPLETED) ||
          completed == HOLDER_ANY_COMPLETED) {
        form.reclamations = await fetchReclamations(form.id ?? -1); //fetchReclamations(form.id!);
        form.category = await getCategory(form.categoryId ?? -1);
        form.fieldSets = [];
        for (var field in d) {
          form.fieldSets!.add(field);
        }
        tmp.add(form);
      }
    }
    return List.from(tmp);
  }

  Future<List<FormFields>> searchFormsAll(String keyword) async {
    final key = "%$keyword%";
    List<FormFields> forms = await searchForms(key);
    List<FormFields> tmp = [];
    for (var form in forms) {
      var d = await fetchFields(form.id!);
      form.fieldSets = [];
      form.category = await getCategory(form.categoryId ?? -1);
      for (var field in d) {
        form.fieldSets!.add(field);
      }
      tmp.add(form);
    }
    return List.from(tmp);
  }

  Future<FormFields> loadFormFieldSets(int formId, int completed) async {
    //Future<FormFields> loadFormFieldSets(AnswerHolder holder, int completed) async {
    FormFields? form = await fetchForms(formId);
    if (form != null) {
      form.reclamations = await fetchReclamations(form.id ?? -1);
      print("getting category ${form.categoryId}, ${form.id}");
      form.category = await getCategory(form.categoryId ?? -1);
      form.answerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(formId, completed);
      form.fieldSets = [];
      var d = await getFieldSetWithQuestions(form.id ?? -1);
      for (var field in d) {
        form.fieldSets!.add(field);
      }
      print("getting category form fields ${form.fieldSets?.length} ");
    }
    return form ?? FormFields.fromJson({});
  }

  Future<void> setForms(List<FormFields> formFields, Hashes? hash) async {
    await removeAllSuperCategories();
    await removeAllCategories();
    await removeAllSubCategories();
    await removeAllFormsFields();
    await removeAllFieldSets();
    await removeAllQuestions();
    await removeAllChoices();
    if (hash == null)
      await removeHashEverything();
    else
      await setHash(hash);
    //await removeAllFormsFields();
    //await setHash(hash)
    List<FormFields> f = [];
    for (var form in formFields) {
      form.createdAtTimeStamp = Jiffy.parse(form.createdAt ?? Jiffy.now().format()).microsecondsSinceEpoch;
      f.add(form);
      if (form.superCategory != null) {
        await insertSuperCategory(form.superCategory!);
        form.superCategoryId = form.superCategory!.id;
      }
      if (form.category != null) {
        await insertCategory(form.category!);
        form.categoryId = form.category!.id;
      }
      if (form.subCategory != null) {
        await insertSubCategory(form.subCategory!);
        form.subCategoryId = form.subCategory!.id;
      }
      if (form.fieldSets != null) await setFields(form.fieldSets!, form.id!);
    }
    await insertForms(f);
  }
}
