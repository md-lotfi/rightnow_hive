import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/category_forms.dart';
import 'package:rightnow/models/category_middle.dart';

class SearchObject {
  final String? keyword;
  final List<CategoryMiddle>? categoriesMiddle;
  final List<CategoryForms>? categories;
  final List<FormFields>? forms;

  SearchObject(this.keyword, this.categoriesMiddle, this.categories, this.forms);
}
