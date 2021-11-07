import 'package:hive/hive.dart';
import 'package:rightnow/db/decision_response_dao.dart';
import 'package:rightnow/models/form_state.dart';

class FormStateDao extends DecisionResponseDao {
  Future<Box<FormFieldsState>> getFormStateDb() async {
    return await Hive.openBox<FormFieldsState>('FormFieldsState');
  }

  //@Query("select * from FormFieldsState")
  Future<List<FormFieldsState>> fetchFormStates() async {
    var f = await getFormStateDb();
    return f.values.toList();
  }

  //@Query("select * from FormFieldsState where id = :id limit 1")
  Future<FormFieldsState?> fetchFormState(int id) async {
    var f = await getFormStateDb();
    return f.values.firstWhere((element) => element.id == id);
  }

  Future<void> removeAllFormStates() async {
    var f = await getFormStateDb();
    await f.clear();
  }

  Future<void> insertFormStatesAll(List<FormFieldsState> formFieldsState) async {
    var f = await getFormStateDb();
    await f.addAll(formFieldsState);
  }

  Future<void> insertFormStates(FormFieldsState formFieldsState) async {
    var f = await getFormStateDb();
    await f.add(formFieldsState);
  }

  Future<void> setFormmStates(List<FormFieldsState> formStates) async {
    await removeAllFormStates();
    print("saving all form states " + formStates.length.toString());
    for (var item in formStates) {
      print('inserting form state ' + item.name!);
      await insertFormStates(item);
    }
  }
}
