import 'package:hive/hive.dart';
import 'package:rightnow/db/MultiSelectAnswersDao.dart';
import 'package:rightnow/models/error_model.dart';
import 'package:collection/collection.dart';

class ErrorModelDao extends MultiSelectAnswersDao {
  Future<Box<ErrorModel>> getErrorModelDb() async {
    return await Hive.openBox<ErrorModel>('ErrorModel');
  }

  //@Query("select * from ErrorModel where questionId = :questionId and fieldSetId = :fieldSetId limit 1")
  Future<ErrorModel?> fetchError(int questionId, int fieldSetId) async {
    var r = await getErrorModelDb();
    return r.values.firstWhereOrNull((element) => element.questionId == questionId && element.fieldSetId == fieldSetId);
  }

  //@Query("select * from ErrorModel where fieldSetId = :fieldSetId limit 1")
  Future<List<ErrorModel>> fetchErrors(int fieldSetId) async {
    var r = await getErrorModelDb();
    return r.values.toList();
  }

  Future<int?> insertError(ErrorModel errorModel) async {
    var r = await getErrorModelDb();
    r.add(errorModel);
  }
}
