import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'HashEvent.freezed.dart';

@freezed
abstract class HashEvent with _$HashEvent {
  const factory HashEvent.getCategoriesHash() = GetCategoriesHash;
  const factory HashEvent.loadCategories(String currentHash) = LoadCategories;
  const factory HashEvent.restoreCategories() = RestoreCategories;
  const factory HashEvent.distract() = Distract;
}
