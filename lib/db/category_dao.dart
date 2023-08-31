import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/sub_category_dao.dart';
import 'package:rightnow/models/category.dart';

class CategoryDao extends SubCategoryDao {
  Future<Box<Category>> getCategoryDb() async {
    return await Hive.openBox<Category>('Category');
  }

  Future<void> removeAllCategories() async {
    var c = await getCategoryDb();
    await c.clear();
  }

  Future<List<Category>> fetchCategories() async {
    var c = await getCategoryDb();
    return c.values.toList();
  }

  /*Future<List<Category>> fetchCategoriesOfSuperCategory(int superCategoryId) async {
    var c = await getCategoryDb();
    return c.values.where((element) => element.superCategoryId == superCategoryId).toList();
  }*/

  Future<Map<String, dynamic>> fetchCategoriesOfSuperCategory(BuildContext context, int superCategoryId) async {
    var c = await getCategoryDb();
    //var f = await FormFields.
    return {
      'categories': c.values.where((element) {
        log("fetching super category ${element.toJson()}, supercat = $superCategoryId");
        return element.superCategoryId == superCategoryId;
      }).toList(),
      'forms':
          (await getDataBase<FormFieldsDao>().loadFormsCategoryId(context, null, HOLDER_ANY_COMPLETED)).where((element) => element.superCategoryId == superCategoryId && element.categoryId == null),
    };
  }

  //@Query("select * from Category where id = :categoryId limit 1")
  Future<Category?> getCategory(int categoryId) async {
    var c = await getCategoryDb();
    return c.values.firstWhere((element) => element.id == categoryId);
  }

  Future<void> insertCategory(Category category) async {
    var c = await getCategoryDb();
    for (var item in c.values) {
      if (item.id == category.id) return;
    }
    /*if (category.belongsTo != null) {
      await insertSuperCategory(category.belongsTo!);
      category.superCategoryId = category.belongsTo!.id;
    }*/
    category.superCategoryId = category.belongsTo?.id;
    await c.add(category);
  }
}
