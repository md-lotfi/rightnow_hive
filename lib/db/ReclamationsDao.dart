import 'package:hive/hive.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:collection/collection.dart';

class ReclamationsDao extends FormStateDao {
  Future<Box<Reclamations>> getReclamationsDb() async {
    return await Hive.openBox<Reclamations>('Reclamations');
  }

  Future<Box<AnswerHolder>> getAnswerHolderDb() async {
    return await Hive.openBox<AnswerHolder>('AnswerHolder');
  }

  //@Query("select * from Reclamations where formEntry = :formId limit 1")
  Future<Reclamations?> fetchReclamations(int formId) async {
    var r = await getReclamationsDb();
    return r.values.firstWhereOrNull((element) => element.formId == formId);
  }

  //@Query("select * from Reclamations")
  Future<List<Reclamations>> fetchReclamationsAll() async {
    var r = await getReclamationsDb();
    return r.values.toList();
  }

  //@Query("delete from Reclamations")
  Future<void> removeAllReclamations() async {
    var r = await getReclamationsDb();
    await r.clear();
  }

  //@Query("update AnswerHolder set state = :state where deviceId = :deviceId")
  Future<AnswerHolder?> setAnswerHolderState(int state, String deviceId) async {
    var ans = await getAnswerHolderDb();
    var a = ans.values.firstWhereOrNull((element) => element.deviceId == deviceId);
    if (a != null) {
      a.state = state;
      await a.save();
    }
  }

  Future<void> insertReclamations(List<Reclamations> choice) async {
    var r = await getReclamationsDb();
    await r.addAll(choice);
  }

  Future<Reclamations?> getReclamations(int formId) async {
    Reclamations? r = await fetchReclamations(formId);
    if (r != null) {
      r.formState = await fetchFormState(r.state ?? -1);
    }
    return r;
  }

  Future<void> setReclamations(List<Reclamations> recs) async {
    await removeAllReclamations();
    List<Reclamations> r = [];
    for (var item in recs) {
      item.formId = item.formEntry?.id ?? -1;
      item.deviceId = item.formEntry?.deviceId ?? "";
      await setAnswerHolderState(item.state!, item.deviceId!);
      r.add(item);
    }
    return await insertReclamations(r);
  }
}
