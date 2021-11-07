import 'package:freezed_annotation/freezed_annotation.dart';

part "categoriesEvent.freezed.dart";

@freezed
abstract class CategoriesEvent with _$CategoriesEvent {
  const factory CategoriesEvent.fetchLocalCategories(int belongsTo) = FetchLocalCategories;
  const factory CategoriesEvent.fetchLocalMiddleCategories(int belongsTo) = FetchLocalMiddleCategories;
  /*const factory CategoriesEvent.loadCategories(String currentHash) =
      LoadCategories;
  const factory CategoriesEvent.restoreCategories() = RestoreCategories;*/
}
