import 'dart:developer';
import 'dart:typed_data';

import 'package:hive/hive.dart';

import 'package:collection/collection.dart';

part 'file_saver.g.dart';

@HiveType(typeId: 80)
class FileSaver extends HiveObject {
  @HiveField(0)
  int questionId;

  @HiveField(1)
  int answerHolderId;

  @HiveField(2)
  String name;

  @HiveField(3)
  String path;

  @HiveField(4)
  Uint8List file;

  @HiveField(5)
  String? extension;

  FileSaver({
    required this.questionId,
    required this.answerHolderId,
    required this.name,
    required this.file,
    required this.path,
    this.extension,
  });

  static Future<Box<FileSaver>> _getFileSaverDb() async {
    return await Hive.openBox<FileSaver>('FileSaver');
  }

  static Future<List<FileSaver>> get() async {
    var r = await _getFileSaverDb();
    return r.values.toList();
  }

  static Future<FileSaver?> getBykey(int? key) async {
    log("getting by key $key");
    if (key == null) return null;
    var r = await _getFileSaverDb();
    return r.get(key); //firstWhereOrNull((element) => element.answerId == answerId);
  }

  /*static Future<Uint8List?> getImageByAnswer(int answerId) async {
    var r = await _getFileSaverDb();
    return r.values.firstWhereOrNull((element) => element.answerId == answerId)?.file;
  }*/

  static Future<void> set(FileSaver fileSaver) async {
    var r = await _getFileSaverDb();
    await r.add(fileSaver);
  }

  static Future<FileSaver?> getLastItem() async {
    var r = await _getFileSaverDb();

    int l = r.values.length - 1;
    log("file saver last item size $l, ${r.values.length}");
    if (l < 0) return null;
    return r.values.toList()[l];
  }

  static Future<void> clear() async {
    var r = await _getFileSaverDb();
    await r.clear();
  }
}
