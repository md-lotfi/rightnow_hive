import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/super_category_dao.dart';
import 'package:rightnow/models/sub_category.dart';

class SubCategoryDao extends SuperCategoryDao {
  Future<Box<SubCategory>> getSubCategoryDb() async {
    return await Hive.openBox<SubCategory>('SubCategory');
  }

  Future<void> removeAllSubCategories() async {
    var c = await getSubCategoryDb();
    await c.clear();
  }

  Future<List<SubCategory>> fetchSubCategories() async {
    var c = await getSubCategoryDb();
    return c.values.toList();
  }

  Future<Map<String, dynamic>> fetchSubCategoriesOfCategory(BuildContext context, int categoryId) async {
    var c = await getSubCategoryDb();
    //var f = await FormFields.
    return {
      'categories': c.values.where((element) {
        log("fetching category ${element.toJson()}, supercat = $categoryId");
        return element.categoryId == categoryId;
      }).toList(),
      'forms': (await getDataBase<FormFieldsDao>().loadFormsCategoryId(context, null, HOLDER_ANY_COMPLETED)).where((element) => element.categoryId == categoryId && element.subCategoryId == null),
    };
  }

  Future<SubCategory?> getSubCategory(int categoryId) async {
    var c = await getSubCategoryDb();
    return c.values.firstWhere((element) => element.id == categoryId);
  }

  Future<void> insertSubCategory(SubCategory category) async {
    var c = await getSubCategoryDb();
    print("checking insert of sub category ${category.id}, ${c.values}");
    for (var item in c.values) {
      print("checking insert of sub category ${item.id}, ${category.id}");
      if (item.id == category.id) {
        print("checking insert of sub category found");
        return;
      } else {
        print("checking insert of sub category not found");
      }
    }
    category.categoryId = category.belongsTo?.id;
    await c.add(category);
  }
}
