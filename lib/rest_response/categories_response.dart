import 'package:rightnow/models/category_forms.dart';

class CategoriesResponse {
  List<CategoryForms> cats = [];

  CategoriesResponse.fromJson(List<dynamic> json) {
    if (json != null) {
      for (var data in json) cats.add(CategoryForms.fromJson(data));
    }
  }
}
