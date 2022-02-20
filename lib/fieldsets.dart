import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/answers_uploader_screen.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/decision_response_dao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/questions_screen.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';

class FieldsSetPage extends StatefulWidget {
  //final FormFields formFields;
  final int formId;
  const FieldsSetPage({Key? key, required this.formId}) : super(key: key);

  @override
  _FieldSetState createState() => _FieldSetState();
}

class _FieldSetState extends State<FieldsSetPage> {
  AnswerHolder? activeAnswerHolder;
  List<AnswerHolder> waitingUploadAnswerHolder = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      floatingActionButton: showWidget(_addFloatingButton(), Container(), (activeAnswerHolder != null || waitingUploadAnswerHolder.length > 0)),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_FORMS_INDEX),
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder<FormFields?>(
        future: getDataBase<FormFieldsDao>().loadFormFieldSets(widget.formId, HOLDER_NOT_COMPLETED),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //print("fetching fieldsets id ${widget.formId}, result ${snapshot.data?.id}");
            return _body(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //dataWidget(widget.formFields.fieldSets ?? [])
    ));
  }

  Widget _body(FormFields? form) {
    if (form == null)
      return Center(
        child: Text("Formulaire est vide"),
      );
    List<Widget> elements = [];
    List<FieldSet> data = form.fieldSets ?? [];
    print("fieldsets found count ${form.fieldSets?.length}");
    for (var item in data) {
      int f = _filterAnswers(form.answerHolder, item.id);
      //int totalQuestions = item.questionsCount ?? 0;
      int totalQuestions = countQuestions(item);
      double progress = (f.toDouble());
      print("fieldsets found questions count $totalQuestions, $progress");
      var d;
      if (progress != 0) {
        d = Container(
          height: 10,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: totalQuestions == 0 ? Colors.grey : ((progress / totalQuestions) < 1 ? Colors.red : Colors.green),
          ),
        );
      } else {
        d = Container(
          height: 10,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
        );
      }
      elements.add(d);
    }
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeaderBarWidget(
          builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios, size: 25, color: COLOR_PRIMARY),
                        onTap: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          form.getName(context.locale.languageCode),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20), color: COLOR_PRIMARY),
                        ),
                      ),
                      Container(),
                      if (form.isAnonymous == true) Image.asset("assets/anonymous.png", width: 25),
                    ],
                  ),
                  if (elements.length > 0) SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 10,
                    child: Center(
                      child: ScrollTouchWidget(
                        listChild: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return Container(
                              width: 10,
                            );
                          },
                          itemCount: elements.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return elements[index];
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              Positioned(
                top: kIsWeb ? 20 : 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: dataWidget(data, form),
              ),
              FutureBuilder(
                future: getDataBase<AnswerHolderDao>().fetchAnswerHolderOne(form.id!, HOLDER_NOT_COMPLETED),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null) {
                      return Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Container(
                          child: TextButton(
                            onPressed: () async {
                              //BlocProvider.of<AnswersPostBloc>(context).add(AnswersEvent.uploadAnswerHolder());
                              await checkSend(context, form, () {
                                SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
                                  setState(() {});
                                });
                              });
                            },
                            child: Text("Envoyer".tr()),
                          ),
                        ),
                      );
                    } else
                      return Container();
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        )),
      ],
    );
  }

  /*_checkSend(FormFields form) async {
    ApiRepository api = ApiRepository();
    bool connected = await api.hasInternetConnection();
    if (!connected) {
      noInternetDialog(context);
      return;
    }
    AnswerHolder? waitingUploadAnswerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderNotClosedWithChildren(form.id!, HOLDER_NOT_COMPLETED);
    if (waitingUploadAnswerHolder != null) {
      if (areValidAnswers(form.fieldSets, waitingUploadAnswerHolder)) {
        LocalUser? lu = await getDataBase<LocalUserDao>().fetchUser();
        showLoaderDialog(context);
        DecisionResponse? sent = await api.postAnswerHolder(lu!.user!, waitingUploadAnswerHolder);
        Navigator.pop(context);
        if (sent != null) {
          print("terminating answer holder ....");
          await getDataBase<AnswerHolderDao>().completeAnswerHolder(waitingUploadAnswerHolder.id!);
          await getDataBase<AnswerHolderDao>().closeAnswerHolderAndSetCompletedTime(waitingUploadAnswerHolder);
          await getDataBase<AnswerHolderDao>().terminateAnswerHolder(waitingUploadAnswerHolder.id!);
          sent.answerHolderId = waitingUploadAnswerHolder.id;
          await getDataBase<DecisionResponseDao>().insertDecisionResponse(sent);
          showResponseDialog(context, sent, () {
            SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
              setState(() {});
            });
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
          desc: "Vous devez répondre à toutes les questions obligatoire afin de pouvoir envoyer vos réponses".tr(),
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
  }*/

  int _filterAnswers(AnswerHolder? answerHolder, int? fieldSetId) {
    if (answerHolder == null) return 0;
    int c = 0;
    for (Answer item in answerHolder.answers ?? []) {
      if (item.fieldSetId == fieldSetId) c++;
    }
    return c;
  }

  Widget dataWidget(List<FieldSet> data, FormFields form) {
    return ScrollTouchWidget(
      listChild: ListView.separated(
        itemBuilder: (context, index) {
          int f = _filterAnswers(form.answerHolder, data[index].id);
          int activeTotalQuestions = countActiveQuestions(data[index]);
          int totalQuestions = countQuestions(data[index]);
          double progress = (f.toDouble());
          print("progress $progress, $totalQuestions, $f");

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionsPage(
                    //key: MyApp.fileWidgetState,
                    key: UniqueKey(),
                    fieldSet: data[index],
                    anonymous: form.isAnonymous ?? false,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    //onTap: () {},
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      data[index].getName(context.locale.languageCode),
                      style: TextStyle(color: COLOR_PRIMARY, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 16), fontWeight: FontWeight.bold),
                    ),
                    trailing: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          activeTotalQuestions.toString(), //progress.floor().toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                        CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          color: totalQuestions == 0 ? Colors.grey : ((progress / totalQuestions) < 1 ? Colors.red : Colors.green),
                          value: totalQuestions == 0 ? 0 : (progress / totalQuestions),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data[index].getDescription(context.locale.languageCode),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        InkWell(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: "Répondre ".tr(), style: TextStyle(color: COLOR_PRIMARY)),
                                WidgetSpan(
                                  child: Icon(Icons.arrow_forward, size: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 15,
            //child: Text(Jiffy().yMMMEd),
          );
        },
        itemCount: data.length,
      ),
    );
  }

  Widget _addFloatingButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      onPressed: () async {
        await getDataBase<AnswerHolderDao>().closeAnswerHolderAndSetCompletedTime(activeAnswerHolder!);
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AnswersUploaderPage()),
          );
        });
      },
      icon: Icon(Icons.cloud_upload),
      label: Text(
        activeAnswerHolder != null
            ? 'Terminer'.tr()
            : waitingUploadAnswerHolder.length > 0
                ? 'Upload'.tr()
                : 'Undéfinie'.tr(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
