import 'package:freezed_annotation/freezed_annotation.dart';

part 'homepageEvent.freezed.dart';

@freezed
abstract class HomePageEvent with _$HomePageEvent {
  const factory HomePageEvent.loadHomePageButtons() = LoadHomePageButtons;
}
