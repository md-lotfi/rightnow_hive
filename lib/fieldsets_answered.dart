import 'dart:developer';

import 'package:rightnow/answers_uploader_screen.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/questions_history_local_screen.dart';
import 'package:rightnow/questions_history_screen.dart';
import 'package:rightnow/screen_viewer.dart';

class FieldsSetAnsweredPage extends StatefulWidget {
  //final FormFields formFields;
  final AnswerHolder answerHolder;
  const FieldsSetAnsweredPage({Key? key, required this.answerHolder}) : super(key: key);

  @override
  _FieldsSetAnsweredState createState() => _FieldsSetAnsweredState();
}

class _FieldsSetAnsweredState extends State<FieldsSetAnsweredPage> {
  AnswerHolder? activeAnswerHolder;
  List<AnswerHolder> waitingUploadAnswerHolder = [];

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  _checkData() {}

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      floatingActionButton: showWidget(_addFloatingButton(), Container(), (activeAnswerHolder != null || waitingUploadAnswerHolder.length > 0)),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder<FormFields?>(
        future: getDataBase<FormFieldsDao>().loadFormFieldSets(widget.answerHolder.formId ?? -1, HOLDER_COMPLETED),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //print("fetching fieldsets id ${widget.formId}, result ${snapshot.data?.id}");
            //return _body(snapshot.data!);
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 80,
                  child: _body(snapshot.data!),
                ),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: TextButton(
                    onPressed: () async {
                      print("decision response is ${widget.answerHolder.decisionResponse}");
                      showResponseDialog(context, widget.answerHolder.decisionResponse, () {});
                    },
                    child: Text("Afficher le résultat".tr()),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //dataWidget(widget.formFields.fieldSets ?? [])
    ));
  }

  Widget _body(FormFields form) {
    List<Widget> elements = [];
    List<FieldSet> data = form.fieldSets ?? [];
    print("fieldsets found count ${form.fieldSets?.length}");
    for (FieldSet item in data) {
      int q = 0;
      for (Answer answer in widget.answerHolder.answers ?? []) {
        if (answer.fieldSetId == item.id) q++;
      }
      int totalQuestions = item.questionsCount ?? 0;
      double progress = (q.toDouble());
      var d = Container(
        height: 10,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: totalQuestions == 0 ? Colors.grey : ((progress / totalQuestions) != 1 ? Colors.red : Colors.green),
        ),
      );

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
                          style: TextStyle(fontSize: 30, color: COLOR_PRIMARY),
                        ),
                      ),
                      Container(),
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
                    )),
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
                top: 0,
                left: 0,
                right: 0,
                bottom: 70,
                child: dataWidget(data),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget dataWidget(List<FieldSet> data) {
    return ScrollTouchWidget(
      listChild: ListView.separated(
        itemBuilder: (context, index) {
          //List<Answer>
          int totalQuestions = 0;
          double progress = 0;
          for (FieldSet item in data) {
            int q = 0;
            for (Answer answer in widget.answerHolder.answers ?? []) {
              if (answer.fieldSetId == item.id) q++;
            }
            totalQuestions = item.questionsCount ?? 0;
            progress = (q.toDouble());
            /*var d = Container(
            height: 10,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: totalQuestions == 0 ? Colors.grey : ((progress / totalQuestions) != 1 ? Colors.red : Colors.green),
            ),
          );

          elements.add(d);*/
          }

          return Container(
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
                  onTap: () async {
                    log("I am in fieldsets_answsred");
                    AnswerHolder? answerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildren(data[index].form!, HOLDER_COMPLETED, any: true, fieldSetId: data[index].id);
                    if (answerHolder != null)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuestionsHistoryLocalPage(
                            fieldSet: data[index],
                            answerHolder: answerHolder,
                          ),
                        ),
                      );
                  },
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  title: Text(
                    data[index].getName(context.locale.languageCode),
                    style: TextStyle(color: COLOR_PRIMARY, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        progress.floor().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: totalQuestions == 0 ? Colors.grey : ((progress / totalQuestions) != 1 ? Colors.red : Colors.green),
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
                          data[index].getDescription(context.locale.languageCode).isEmpty ? "Une petite description de la section pour avoir une idée générale" : "",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      InkWell(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: "Réponse ".tr(), style: TextStyle(color: COLOR_PRIMARY)),
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
    /*return GridView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        /*print("current field sets questions " +
            data[index].questions.length.toString());*/
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsPage(
                  key: MyApp.fileWidgetState,
                  fieldSet: data[index],
                ),
              ),
            ).then((value) {
              setState(() {
                _checkData();
              });
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: 15),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(color: COLOR_PRIMARY, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0, bottom: 0),
                        child: Image(
                          width: 50,
                          color: Colors.white,
                          image: AssetImage(
                            "assets/formulaire.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    data[index].getName(context.locale.languageCode),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: COLOR_PRIMARY, fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
    );*/
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
