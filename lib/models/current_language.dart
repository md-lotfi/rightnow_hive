import 'package:hive/hive.dart';
import 'package:rightnow/views/language_switch.dart';

part 'current_language.g.dart';

@HiveType(typeId: 124)
class CurrentLanguage extends HiveObject {
  @HiveField(0)
  String? language;
  CurrentLanguage({
    this.language,
  });

  static Future<Box<CurrentLanguage>> _getCurrentLanguageDb() async {
    return await Hive.openBox<CurrentLanguage>('CurrentLanguage');
  }

  static Future<String> getLang() async {
    var r = await _getCurrentLanguageDb();
    return r.values.firstOrNull?.language ?? LANGUAGE_FR;
  }

  static Future<void> set(CurrentLanguage currentlanguage) async {
    var r = await _getCurrentLanguageDb();
    await r.clear();
    await r.add(currentlanguage);
  }

  static Future<void> clear() async {
    var r = await _getCurrentLanguageDb();
    await r.clear();
  }
}
