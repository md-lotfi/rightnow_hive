import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProvinceEvent.freezed.dart';

@freezed
abstract class ProvinceEvent with _$ProvinceEvent {
  const factory ProvinceEvent.serverLoadProvinces() = ServerLoadProvinces;
  const factory ProvinceEvent.loadProvinces() = LoadProvinces;
  const factory ProvinceEvent.loadTowns(String provinceId) = LoadTowns;
  const factory ProvinceEvent.distract() = Distract;
}
