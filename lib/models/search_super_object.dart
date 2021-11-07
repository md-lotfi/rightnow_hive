import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/super_category.dart';

class SearchSuperObject {
  final String? keyword;
  final List<SuperCategory>? superCategories;

  SearchSuperObject(this.keyword, this.superCategories);
}
