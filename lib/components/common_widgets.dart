import 'dart:io';
import 'dart:typed_data';

import 'package:jiffy/jiffy.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/FormsDescription.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/ProfileDao.dart';
import 'package:rightnow/db/QuestionsDao.dart';
import 'package:rightnow/db/decision_response_dao.dart';
import 'package:rightnow/dialogs/questions_validate_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:rightnow/models/answers_count.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/recommandation.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

List<Widget> showWidgetList(List<Widget> widgets, List<Widget> elseWidgets, bool show) {
  if (show) {
    return widgets;
  } else {
    return elseWidgets;
  }
}

Widget showWidget(Widget widgets, Widget elseWidgets, bool show) {
  if (show) {
    return widgets;
  } else {
    return elseWidgets;
  }
}

dynamic getFirstOrNull(Iterable i) {
  if (i.length == 0) return null;
  return i.first;
}

InlineSpan showInlineSpan(InlineSpan widgets, InlineSpan elseWidgets, bool show) {
  if (show) {
    return widgets;
  } else {
    return elseWidgets;
  }
}

bool isDate(String str) {
  try {
    DateTime.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

Widget widgetQuestionTitle(Question question, String lang) {
  return Padding(
    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 10),
    child: RichText(
      text: TextSpan(
        style: new TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: question.getName(lang)), // + " " + question.id.toString()
          showInlineSpan(
            WidgetSpan(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "*",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            TextSpan(),
            isRequired(question), //is_required
          ),
        ],
      ),
    ),
  );
  /*TextSpan(
              text: '*',
              style: new TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            )*/
}

bool isRequired(Question? q) {
  if (q == null) return false;
  //if (q.resourcetype == BOOLEAN_QUESTION) return false;
  return (q.isRequired ?? false) && (q.activeAlways ?? false);
}

bool isRequiredForValidate(Question? q) {
  if (q == null) return false;
  if (!(q.isActive ?? true)) return false;
  if (q.resourcetype == BOOLEAN_QUESTION) return false;
  //if( q.activeAlways ?? false )
  return (q.isRequired ?? false) && (q.activeAlways ?? false);
}

bool isEmail(String em) {
  String p = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+";
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

Future<bool> hasRequiredFields(int fieldSetId) async {
  List<Question> qs = await getDataBase<QuestionsDao>().fetchQuestion(fieldSetId);
  for (var q in qs) {
    if (isRequired(q)) return true;
  }
  return false;
}

bool isActive(Question? q) {
  if (q == null) return false;
  //if (q.resourcetype == BOOLEAN_QUESTION) return false;
  return (q.isActive ?? false);
}

bool areValidAnswers(List<FieldSet>? form, AnswerHolder? _answerHolder) {
  bool c = true;
  for (FieldSet f in form ?? []) {
    print('checking form ${f.id}');
    for (Question q in f.questions ?? []) {
      print('checking q ${f.id}');
      if (isRequiredForValidate(q)) {
        print("checking question ${q.id}");
        var containsAnswer = _answerHolder?.answers?.where((element) {
              print("checking response ${element.qustionId}");
              return element.qustionId == q.id;
            }) ??
            [];
        if (containsAnswer.isEmpty) {
          print("missing answer " + q.id.toString() + ", " + q.resourcetype! + ", " + (q.branchedConditions?.length.toString() ?? "0") + ", " + (q.depandantConditions?.length.toString() ?? "0"));
          c = false;
          break;
        }
      }
    }
    if (!c) break;
  }
  return c;
}

Widget fieldTitle(BuildContext context, String title) {
  return Container(
    alignment: isFrench(context) ? Alignment.centerLeft : Alignment.centerRight,
    child: Text(
      title.tr(),
      style: TextStyle(fontSize: 18, color: COLOR_PRIMARY, fontWeight: FontWeight.w600),
    ),
  );
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Expanded(
          child: Container(margin: EdgeInsets.only(left: 7), child: Text("Sending data".tr())),
        )
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

redirectUser(Function() userLogged, Function() userNotLogged) async {
  LocalUser? user = await getDataBase<LocalUserDao>().fetchUser();
  if (user != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs.getString(AUTH_KEY);
    if (key != null) {
      userLogged();
      return;
    }
  }
  userNotLogged();
}

Widget addSetting(BuildContext context, {String title = "", Function()? action, Icon? icon, Color? color, Color? titleColor, bool vertical = true}) {
  if (action != null) {
    return InkWell(
      onTap: () {
        action();
      },
      child: _addSettingContent(context, title: title, icon: icon, color: color, titleColor: titleColor, vertical: vertical),
    );
  } else {
    return _addSettingContent(context, title: title, icon: icon, color: color, titleColor: titleColor, vertical: vertical);
  }
}

Widget _addSettingContent(BuildContext context, {String title = "", Icon? icon, Color? color, Color? titleColor, bool vertical = true}) {
  return Container(
    decoration: BoxDecoration(color: color == null ? Colors.white : color, borderRadius: BorderRadius.all(Radius.circular(10.0))),
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.only(left: 15, top: 15),
    child: vertical
        ? Column(
            children: settingsContentElemV(context, title: title, icon: icon, titleColor: titleColor),
          )
        : Row(
            children: settingsContentElemH(context, title: title, icon: icon, titleColor: titleColor),
          ),
  );
}

List<Widget> settingsContentElemH(BuildContext context, {String title = "", Icon? icon, Color? titleColor}) {
  return [
    Expanded(
      flex: 1,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Center(
          child: icon ?? Icon(MdiIcons.cog),
        ),
      ),
    ),
    SizedBox(
      width: 10,
    ),
    Expanded(
      flex: 9,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: titleColor,
        ),
      ),
    )
  ];
}

List<Widget> settingsContentElemV(BuildContext context, {String title = "", Icon? icon, Color? titleColor}) {
  return [
    Expanded(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Center(
          child: icon ?? Icon(MdiIcons.cog),
        ),
      ),
    ),
    SizedBox(
      height: 10,
    ),
    Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: titleColor,
          fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 12),
        ),
      ),
    ),
  ];
}

showResponseDialog(BuildContext context, DecisionResponse? decision, Function() onClose) {
  if (decision == null) return;
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommandationPage(decision: decision),
      )).then((value) => onClose);
}

Future<int> countAnswersOpenHolder(int? formId) async {
  if (formId == null) return 0;
  int c = 0;
  AnswerHolder? a = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(formId);
  if (a != null) {
    for (var answer in a.answers ?? []) {
      c++;
    }
  }
  return c;
}

Future<int> countAnswers(int? formId, {bool any = false}) async {
  if (formId == null) return 0;
  int c = 0;
  AnswerHolder? a = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(formId, any: any);
  if (a != null) {
    for (var answer in a.answers ?? []) {
      c++;
    }
  }
  return c;
}

/*Future<int> countquestions(int? formId) async {
  if (formId == null) return 0;
  int c = 0;
  AnswerHolder? a = await getDataBase<FormFieldsDao>().fetchFields(formId)
  if (a != null) {
    for (var answer in a.answers ?? []) {
      c++;
    }
  }
  return c;
}*/

/*Future<int> countAnswersOfHolder(int? holderId) async {
  if (holderId == null) return 0;
  int c = 0;
  AnswerHolder? a = await getDataBase().answerHolderDao.fetchAnswerHolderWithChildren(formId, any: any);
  if (a != null) {
    for (var answer in a.answers ?? []) {
      c++;
    }
  }
  return c;
}*/

Future<int> countFieldSetAnswers(/*AnswerHolder? answerHolder,*/ int? fieldSetId) async {
  return 0;
  /*if (answerHolder == null) return 0;
  int c = 0;
  //print("answers found == ${h?.answers?.length}");
  for (Answer item in answerHolder.answers ?? []) {
    //print("answers found == ${item.id}, ${item.fieldSetId}, $fieldSetId");
    if (item.fieldSetId == fieldSetId) c++;
  }
  return c;*/
  /*print("formId and fieldSetId are $formId, $fieldSetId");
  if (formId == null || fieldSetId == null) {
    print("formId and fieldSetId are null");
    return 0;
  }
  AnswerHolder? h = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(formId); //getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(formId);
  int c = 0;
  print("answers found == ${h?.answers?.length}");
  for (Answer item in h?.answers ?? []) {
    print("answers found == ${item.id}, ${item.fieldSetId}, $fieldSetId");
    if (item.fieldSetId == fieldSetId) c++;
  }
  return c;*/
  /*print("formId and fieldSetId are $formId, $fieldSetId, result ${h!.id}");
  int c = 0;
  List<Answer>? a = await getDataBase<AnswersDao>().fetchFiledSetAnswers(fieldSetId, h.id ?? -1);
  if (a != null) {
    return a.length;
  }
  print("final count is $c");
  return c;*/
}

/*Future<int> countFieldSetAnswers(int? fieldSetId) async {
  if (fieldSetId == null) return 0;
  int c = 0;
  List<Answer>? a = await getDataBase().answerDao.fetchFiledSetAnswers(fieldSetId);
  if (a != null) {
    for (var answer in a) {
      c++;
    }
  }
  return c;
}*/

bool isActiveAlways(Question? q) {
  if (q == null) return false;
  return q.activeAlways ?? false;
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void fieldsAnswersAlreadyExists(BuildContext context, FormFields formFields) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return QuestionsValidateDialog(
        title: "Confirmation".tr(),
        descriptions: "Un formulaire est déja ouvert, voulez-vous continuer ou rejeter ce formulaire et crée un nouveau?".tr(),
        textPositive: "Continuer".tr(),
        textNegative: "Rejeter".tr(),
        onButtonClicked: (int which) async {
          switch (which) {
            case 1:
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormsDescription(
                              form: formFields,
                            )));
              });
              break;
            case -1:
              await getDataBase<AnswerHolderDao>().deleteUnclosedAnswerHolder(formFields.id!).then((value) {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormsDescription(
                                form: formFields,
                              )));
                });
              });
              break;
            default:
              print("undefined button action");
              break;
          }
        },
      );
    },
  ).then((value) {
    //Navigator.pop(context);
  });
}

Widget loadImage(String? src) {
  if (src != null) {
    if (src != "") {
      FadeInImage.assetNetwork(placeholder: 'assets/loading.gif', image: src);
    }
  }
  return Image(
    image: AssetImage("assets/brain_head.png"),
    color: Colors.white,
  );
}

Widget addBlocHandlerSpinner<T extends BlocBase<S>, S extends ResultState<dynamic>>({
  Function(dynamic data)? onFinish,
  Function(NetworkExceptions? error)? onError,
  bool Function(S prev, S state)? buildWhen,
  //Function(dynamic error)? onUnHandledError,
  //Function()? onUnAuthorized,
  Function()? onIdle,
}) {
  return BlocBuilder<T, S>(
    buildWhen: buildWhen,
    builder: (BuildContext context, S state) {
      print("user page state received ...2");
      return state.when(
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
        idle: () {
          if (onIdle != null) return onIdle();
          return Container();
        },
        data: (dynamic data) {
          if (onFinish != null) return onFinish(data);
          return Container();
        },
        error: (NetworkExceptions? error) {
          /*if (onUnAuthorized != null && error != null) {
            error.maybeWhen(
              unauthorisedRequest: () {
                return onUnAuthorized();
              },
              orElse: () {
                if (onError != null) return onError(error);
              },
            );
          }*/
          if (onError != null) return onError(error);
          return Container();
        },
      );
    },
  );
}

Widget addBlocProviderHandlerSpinner<T extends BlocBase<S>, S extends ResultState<dynamic>>({
  Function(dynamic data)? onFinish,
  Function(dynamic error)? onError,
  Function()? onUnAuthorized,
  required T callEvent,
}) {
  return BlocProvider<T>(
    create: (context) {
      print('calling provider event ........');
      return callEvent;
    },
    child: BlocBuilder<T, S>(
      builder: (BuildContext context, S state) {
        print("user page state received ...2");
        return state.when(
          loading: () {
            return Center(child: CircularProgressIndicator());
          },
          idle: () {
            return Container();
          },
          data: (dynamic data) {
            if (onFinish != null) return onFinish(data);
            return Container();
          },
          error: (NetworkExceptions? error) {
            if (onUnAuthorized != null && error != null) {
              error.maybeWhen(
                unauthorisedRequest: (response) {
                  return onUnAuthorized();
                },
                orElse: () {
                  if (onError != null) return onError(error);
                },
              );
            }
            if (onError != null) return onError(error);
            return Container();
          },
        );
      },
    ),
  );
}

/*redirectToProfilePage(BuildContext context, AppDatabase database) async {
  List<Province> provinces = await database.provinceDao.fetchProvinces();
  if (provinces.length > 0) {
    Profile? p = await getDataBase().profileDao.fetchUserProfile();
    if (p != null) {
      if (p.email != null) {
        if (p.email!.isNotEmpty) {
          print("checking if user exists redirecting");
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            BlocProvider.of<HashBloc>(context).add(HashEvent.getCategoriesHash());
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HashPage(
                          appDatabase: getDataBase(),
                        )));
          });
          return;
        }
      }
    }
    LocalUser? user = await getDataBase().localUser.fetchUser();
    if (user != null) {
      ApiRepository api = ApiRepository();
      Profile p = await api.getProfile(user.user!);
      await getDataBase().profileDao.setProfile(p);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            appDatabase: database,
          ),
        ),
      );
    }
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProvincesHadlerPage(
          appDatabase: database,
        ),
      ),
    );
  }
}*/

Future<void> showActionMessage(BuildContext context, {String title: "Apoce", List<Widget>? messages, String? positiveBtn, String? negativeBtn, Function(String)? whichTaped, dissmiss: true}) {
  String result = "";
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: messages!,
            ),
          ),
          actions: <Widget>[
            negativeBtn != null
                ? TextButton(
                    child: Text(
                      negativeBtn,
                      style: TextStyle(color: COLOR_PRIMARY),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      //Navigator.of(context).pop();
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        Navigator.of(context).pop();
                      });
                      result = 'Negative';
                    },
                  )
                : Container(),
            positiveBtn != null
                ? TextButton(
                    child: Text(
                      positiveBtn,
                    ),
                    onPressed: () async {
                      print("positive btn pushed .....");
                      if (dissmiss) {
                        WidgetsBinding.instance!.addPostFrameCallback((_) async {
                          Navigator.of(context).pop();
                        });
                      }
                      result = 'Positive';
                    },
                  )
                : Container(),
          ],
        );
      }).then((value) => {if (whichTaped != null) whichTaped(result)});
}

Widget titleText(String text) {
  return Text(
    text.toUpperCase(),
    style: TextStyle(
      fontSize: 18,
    ),
  );
}

Widget bodyText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
    ),
  );
}

/*Widget _header() {
  return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            child: Row(
              children: [
                Image.asset(
                  "assets/axa-logo.png",
                  fit: BoxFit.contain,
                  width: 70,
                ),
                FutureBuilder<LocalUser?>(
                  future: getDataBase().localUser.fetchUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return Container(
                            margin: EdgeInsets.only(left: 15),
                            alignment: Alignment.center,
                            //color: Colors.yellow,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Bonjour".tr(),
                                  style: TextStyle(
                                    color: COLOR_PRIMARY,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                Text(
                                  snapshot.data?.username ?? "",
                                  style: TextStyle(
                                    color: COLOR_PRIMARY,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 28,
                                  ),
                                ),
                              ],
                            ),
                          );
                          /*return RichText(
                        text: TextSpan(
                          text: "Bonjour".tr(),
                          style: TextStyle(color: COLOR_PRIMARY),
                          children: [
                            TextSpan(
                              text: snapshot.data?.username ?? "",
                            )
                          ],
                        ),
                      );*/
                        }
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            child: Icon(
              Icons.notifications_outlined,
              size: 50,
              color: COLOR_PRIMARY,
            ),
          ),
        ],
      ));
}*/

Future<Profile?> getProfile(BuildContext context) async {
  LocalUser? user = await getDataBase<LocalUserDao>().fetchUser();
  if (user != null) {
    ApiRepository api = ApiRepository();
    Profile? wp = await api.getProfile(user.user!);
    if (wp != null) {
      await getDataBase<ProfileDao>().setProfile(wp);
      return wp;
    } else {
      return await getDataBase<ProfileDao>().fetchUserProfile();
    }
  } else {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }
  return null;
}

Widget articlaHeaderColumn(BuildContext context, Actualite actualite) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 25),
        Text(
          actualite.getTitle(context.locale.languageCode),
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20)), //28
        ),
        SizedBox(height: 10),
        Text(
          Jiffy(actualite.createdAt).format("dd MMMM yyyy . HH:mm"),
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.grey.shade400),
        ),
      ],
    ),
  );
}

Widget articleHeader(BuildContext context, Actualite actualite) {
  return Container(
    child: Stack(
      children: [
        Image.network(
          actualite.thumbnail ?? "",
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/welcome.png', width: double.infinity, fit: BoxFit.fill);
          },
        ),
        /*Positioned(
          bottom: MediaQuery.of(context).size.height / 2,
          left: 0,
          right: 0,
          child: Image.asset("assets/transparent_bg.png"),
        ),*/
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/transparent_bg.png"),
              fit: BoxFit.cover,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red,
                  ),
                  child: Text(
                    "Faits marquants".tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  actualite.getTitle(context.locale.languageCode),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(height: 5),
                Text(
                  Jiffy(actualite.createdAt).format("dd MMMM yyyy . HH:mm"),
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

bool isFrench(BuildContext context) {
  return context.locale.languageCode == 'fr' || context.locale.languageCode == 'en';
}

Widget errorMessage(BuildContext context, String msg, Function() onClose) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Colors.red.shade200,
      borderRadius: BorderRadius.circular(8),
    ),
    child: ListTile(
      //tileColor: Colors.redAccent,
      title: Text(
        msg,
        style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 12)),
      ),

      leading: InkWell(
        onTap: () {
          onClose();
        },
        child: Icon(Icons.close),
      ),
    ),
  );
}

int countQuestions(FieldSet fieldSet) {
  int i = 0;
  print("questions count depandant count ${fieldSet.questions?.length}, ${fieldSet.questionsCount}");
  for (Question item in fieldSet.questions ?? []) {
    if (!isActive(item)) continue;
    if (item.depandantConditions != null) if (item.depandantConditions!.length > 0) {
      print("questions count depandant ${item.depandantConditions!.length}, ${item.id}, $i");
      continue;
    }
    //print("questions count depandant increment ${item.depandantConditions!.length}, ${item.id}, $i");
    i++;
  }
  return i;
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

Future<String?> saveFile(File f, String filename) async {
  print("saving file to disk");
  final dir = await getExternalStorageDirectory();
  if (dir != null) {
    print("saving file to disk $dir");
    final fPath = dir.path + "/$filename" + extension(f.path);
    print("saving file to disk $fPath");
    File fFile = File(fPath);
    if (!await fFile.exists()) {
      await fFile.create(recursive: true);
    } else {
      await fFile.delete();
    }
    await fFile.writeAsBytes(f.readAsBytesSync());
    return fFile.path;
  }
  return null;
}

String getFilename(String file) {
  File f = File(file);
  return basename(f.path);
}

Future<bool> saveUint8ListFile(Uint8List f, String filename) async {
  print("saving file to disk");
  final dir = await getExternalStorageDirectory();
  if (dir != null) {
    print("saving file to disk $dir");
    final fPath = dir.path + "/$filename";
    print("saving file to disk $fPath");
    File fFile = File(fPath);
    if (!await fFile.exists()) {
      await fFile.create(recursive: true);
    } else {
      await fFile.delete();
    }
    await fFile.writeAsBytes(f);
    return true;
  }
  return false;
}

Future<Uint8List?> getUint8ListFile(String filename) async {
  print("getting saved file from disk");
  final dir = await getExternalStorageDirectory();
  if (dir != null) {
    final fPath = dir.path + "/$filename";
    print("getting saved file from disk $fPath");
    File fFile = File(fPath);
    if (await fFile.exists()) {
      print("getting saved file from disk file exists, loading it ...");
      return fFile.readAsBytesSync();
    }
  }
  return null;
}

String? checkValueValid({String? value, String? maxValue, String? minValue, bool? required}) {
  if (value?.isNotEmpty ?? false) {
    if (isNumeric(value)) {
      double? max;
      double? min;
      double i = double.tryParse(value ?? "0") ?? 0;
      if (maxValue != null) max = double.tryParse(maxValue) ?? null;
      if (minValue != null) min = double.tryParse(minValue) ?? null;
      print("max min value $max, $min, $maxValue, $minValue");
      if (max != null) {
        if (i > max) return FORM_VALUE_MAX_EXCEEDED + (maxValue ?? "0");
      }
      if (min != null) {
        if (i < min) return FORM_VALUE_MIN_EXCEEDED + (minValue ?? "0");
      }
    } else
      return FORM_VALUE_NUMERIC_ONLY;
    return null;
  } else {
    if (!(required ?? false)) return null; //isRequired(question)
    return FORM_MESSAGES_REQUIRED;
  }
}

String? checkEmailValueValid({String? value, bool? required}) {
  if (value!.isNotEmpty) {
    if (isEmail(value)) return null;
    return FORM_INVALID_EMAIL;
  } else {
    if (!(required ?? false)) return null; //isRequired(question)
    return FORM_MESSAGES_REQUIRED;
  }
}

int countActiveQuestions(FieldSet fieldSet) {
  int i = 0;
  for (Question item in fieldSet.questions ?? []) {
    if (!isActive(item)) continue;
    i++;
  }
  return i;
}

Widget fieldData(String? content) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(content ?? ""),
  );
}

Widget fieldDataMultiLine(List<String>? content) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        for (var item in content ?? []) Text(item),
      ],
    ),
  );
}

void noInternetDialog(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Pas d'internet".tr(),
    desc: "Veuillez vérifier votre connexion.".tr(),
    buttons: [
      DialogButton(
        child: Text(
          "Ok".tr(),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        color: Colors.red,
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

/// Not Implemented Yet */
Future<void> postWaitingForms(BuildContext context) async {
  ApiRepository api = ApiRepository();
  bool connected = await api.hasInternetConnection();
  if (!connected) {
    noInternetDialog(context);
    return;
  }
  List<FormFields> forms = await getDataBase<FormFieldsDao>().fetchFormsAny(context);

  for (var form in forms) {
    AnswerHolder? waitingUploadAnswerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderNotClosedWithChildren(form.id!);
    if (waitingUploadAnswerHolder != null) {
      if (areValidAnswers(form.fieldSets, waitingUploadAnswerHolder)) {
        LocalUser? lu = await getDataBase<LocalUserDao>().fetchUser();
        showLoaderDialog(context);
        DecisionResponse? sent = await api.postAnswerHolder(lu!.user!, waitingUploadAnswerHolder);
        Navigator.pop(context);
        if (sent != null) {
          print("terminating answer holder ....");
          await getDataBase<AnswerHolderDao>().closeAnswerHolderAndSetCompletedTime(waitingUploadAnswerHolder);
          await getDataBase<AnswerHolderDao>().terminateAnswerHolder(waitingUploadAnswerHolder.id!);
          sent.answerHolderId = waitingUploadAnswerHolder.id;
          await getDataBase<DecisionResponseDao>().insertDecisionResponse(sent);
          showResponseDialog(context, sent, () {
            /*SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
              setState(() {});
            });*/
          });
        } else {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Erreur".tr(),
            desc: "Erreur au niveau du serveur.".tr(),
            buttons: [
              DialogButton(
                child: Text(
                  "Ok".tr(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                color: Colors.red,
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "Attention".tr(),
          desc: "Vous devez répondre sur toute les questions obligatoires pour pouvoir envoyer vos réponses.".tr(),
          buttons: [
            DialogButton(
              child: Text(
                "Ok".tr(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.red,
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }
}

/// Count answers in forms page */
AnswersCount countAnswersForm(FormFields form) {
  AnswersCount a = AnswersCount();
  for (FieldSet item in form.fieldSets ?? []) {
    a.realTotalQuestions += countActiveQuestions(item);
    a.totalQuestions += countQuestions(item);
  }
  a.progress = ((form.answerHolder?.answers?.length ?? 0).toDouble()) / a.totalQuestions;
  return a;
}

/// Count answers in history page */
AnswersCount countAnswersHolder(AnswerHolder holder) {
  AnswersCount a = AnswersCount();
  for (FieldSet item in holder.formFields?.fieldSets ?? []) {
    a.realTotalQuestions += countActiveQuestions(item);
    a.totalQuestions += countQuestions(item);
  }
  a.progress = ((holder.answers?.length ?? 0).toDouble()) / a.totalQuestions;
  return a;
}
