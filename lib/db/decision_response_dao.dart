import 'package:hive/hive.dart';
import 'package:rightnow/db/category_dao.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:collection/collection.dart';

class DecisionResponseDao extends CategoryDao {
  Future<Box<DecisionResponse>> getDecisionResponseDb() async {
    return await Hive.openBox<DecisionResponse>('DecisionResponse');
  }

  Future<void> removeAllDecisionResponse() async {
    var d = await getDecisionResponseDb();
    await d.clear();
  }

  //@Query("select * from DecisionResponse where answerHolderId = :answerHolderId")
  Future<DecisionResponse?> fetchDecisionResponse(int answerHolderId) async {
    //print("formId and fieldsetId inside desicision response");
    var d = await getDecisionResponseDb();
    //print("formId and fieldsetId after desicision response");
    //print("get decision resonse db ${d.values.first.toJson().toString()}");
    //print("get decision resonse db holderId $answerHolderId");
    return d.values.firstWhereOrNull((element) => element.answerHolderId == answerHolderId);
  }

  Future<void> insertDecisionResponse(DecisionResponse decisionResponse) async {
    var d = await getDecisionResponseDb();
    await d.add(decisionResponse);
  }
}
