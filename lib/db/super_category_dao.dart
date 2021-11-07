import 'package:hive/hive.dart';
import 'package:rightnow/models/super_category.dart';

class SuperCategoryDao {
  Future<Box<SuperCategory>> getSuperCategoryDb() async {
    return await Hive.openBox<SuperCategory>('SuperCategory');
  }

  Future<void> removeAllSuperCategories() async {
    var c = await getSuperCategoryDb();
    await c.clear();
  }

  Future<List<SuperCategory>> fetchSuperCategories() async {
    var c = await getSuperCategoryDb();
    return c.values.toList();
  }

  //@Query("select * from Category where id = :categoryId limit 1")
  Future<SuperCategory?> getSuperCategory(int categoryId) async {
    var c = await getSuperCategoryDb();
    return c.values.firstWhere((element) => element.id == categoryId);
  }

  Future<void> insertSuperCategory(SuperCategory category) async {
    var c = await getSuperCategoryDb();
    print("checking insert of category ${category.id}, ${c.values}");
    for (var item in c.values) {
      print("checking insert of category ${item.id}, ${category.id}");
      if (item.id == category.id) {
        print("checking insert of category found");
        return;
      } else {
        print("checking insert of category not found");
      }
    }
    await c.add(category);
  }
}
