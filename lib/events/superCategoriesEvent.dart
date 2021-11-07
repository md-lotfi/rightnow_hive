import 'package:freezed_annotation/freezed_annotation.dart';

part "superCategoriesEvent.freezed.dart";

@freezed
abstract class SuperCategoriesEvent with _$SuperCategoriesEvent {
  const factory SuperCategoriesEvent.fetchLocalSuperCategories() = FetchLocalSuperCategories;
}
