import 'package:hive/hive.dart';

part 'home_buttons.g.dart';

@HiveType(typeId: 26)
class HomeButtons {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? categoryId;

  @HiveField(2)
  String? title;

  HomeButtons(this.id, this.title, this.categoryId);

  HomeButtons.fill(this.title, this.categoryId);
}
