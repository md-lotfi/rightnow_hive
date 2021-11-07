import 'package:hive/hive.dart';
import 'package:rightnow/db/super_category_dao.dart';
import 'package:rightnow/models/category.dart';

class CategoryDao extends SuperCategoryDao {
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

  Future<List<Category>> fetchCategoriesOfSuperCategory(int superCategoryId) async {
    var c = await getCategoryDb();
    return c.values.where((element) => element.superCategoryId == superCategoryId).toList();
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
    if (category.belongsTo != null) {
      await insertSuperCategory(category.belongsTo!);
      category.superCategoryId = category.belongsTo!.id;
    }
    await c.add(category);
  }
}
