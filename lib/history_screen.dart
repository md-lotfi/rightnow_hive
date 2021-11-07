import 'package:jiffy/jiffy.dart';
import 'package:rightnow/blocs/reclamations_bloc.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/components/tabs_header.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/events/ReclamationsEvent.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/fieldsets_answered.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/form_state.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //List<AnswerHolder> waitingUploadAnswerHolder = [];

  ApiRepository api = ApiRepository();

  int _selectedId = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReclamationsBloc>(context).add(ReclamationsEvent.myReclamations());
  }

  _HistoryPageState();

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HISTORY_INDEX),
      backgroundColor: Colors.grey.shade50,
      body: _body(),
    ));
  }

  Widget _body() {
    return Column(
      children: [
        HeaderBarWidget(
          builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Icon(Icons.arrow_back_ios, size: 25, color: COLOR_PRIMARY),
                        onTap: () => Navigator.pop(context),
                      ),
                      Text(
                        "Historique".tr(),
                        style: TextStyle(fontSize: 30, color: COLOR_PRIMARY),
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryPage(),
                          ),
                        ),
                        child: Icon(Icons.history, size: 25, color: COLOR_PRIMARY),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  TabsHeaderWidget(
                    onSelected: (selectedId) {
                      setState(() {
                        _selectedId = selectedId;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: FutureBuilder<List<FormFieldsState>>(
            future: getDataBase<FormStateDao>().fetchFormStates(), //api.fetchFormState(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return FutureBuilder<List<Reclamations>?>(
                    future: api.fetchReclamationsRaw(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return FutureBuilder<List<AnswerHolder>>(
                          future: getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildrenAll(_selectedId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return _dataWidget(snapshot.data);
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  //return _dataWidget(data); //_main();
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _dataWidget(List<AnswerHolder>? data) {
    return Center(
        child: RefreshIndicator(
      child: RawScrollbar(
        isAlwaysShown: true,
        thumbColor: COLOR_PRIMARY,
        child: _builder(data),
      ),
      onRefresh: () async {
        setState(() {});
        //BlocProvider.of<HistoryBloc>(context).add(HistoryEvent.loadHistory());
        return await Future.delayed(
          Duration(seconds: 3),
        );
      },
    ));
  }

  Widget _listDivider(String text) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          width: double.infinity,
          height: 1,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          child: Text(text, style: TextStyle(backgroundColor: Colors.grey.shade50)),
        ),
      ],
    );
  }

  Widget _builder(List<AnswerHolder>? data) {
    if (data == null) return Container();
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      separatorBuilder: (context, index) {
        if (data.length == 0) return Container();
        if ((index + 1) == (data.length + 1)) return Container();
        if (index == 0) return Container();
        return _listDivider(Jiffy(data[index].completedAt).format("dd MMMM yyyy"));
      },
      itemCount: data.length + 2,
      itemBuilder: (BuildContext context, int index) {
        if (data.length == 0) return Container();
        String f = "";
        if ((index + 1) == (data.length + 2)) return Container();
        if (index == 0) {
          return _listDivider(Jiffy(data[index].completedAt).format("dd MMMM yyyy"));
        }
        if (data[index - 1].completedAt != null) {
          DateTime d = DateTime.parse(data[index - 1].completedAt ?? "");
          f = DateFormat('dd/MM/yyyy').format(d);
          print('date is ' + f);
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
          child: _tile(data[index - 1], f),
          //child: Card(child: _tile(data[index], f)),
        );
      },
    );
  }

  Widget _setTileHeader(AnswerHolder data) {
    return Row(
      children: [
        showWidget(
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Non envoyé".tr(),
                style: TextStyle(color: Colors.white, backgroundColor: Colors.red, fontSize: 10),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Envoyé".tr(),
                style: TextStyle(color: Colors.white, backgroundColor: Colors.green, fontSize: 10),
              ),
            ),
            data.uploaded == false),
        if (data.state != null)
          FutureBuilder<FormFieldsState?>(
            future: getDataBase<FormStateDao>().fetchFormState(data.state!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Container(
                    padding: EdgeInsets.all(5),
                    margin: isFrench(context) ? EdgeInsets.only(left: 8) : EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      snapshot.data!.getName(context.locale.languageCode),
                      style: TextStyle(color: Colors.white, backgroundColor: Colors.blue, fontSize: 10),
                    ),
                  );
                }
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        if (data.formFields?.isAnonymous == true)
          Container(
            padding: EdgeInsets.all(5),
            margin: isFrench(context) ? EdgeInsets.only(left: 8) : EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
            child: Text(
              "Anonyme".tr(),
              style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: 10),
            ),
          ),
      ],
    );
  }

  Widget _tile(AnswerHolder data, String f) {
    int totalQuestions = 0;
    for (FieldSet item in data.formFields?.fieldSets ?? []) {
      totalQuestions += item.questionsCount ?? 0;
    }
    double progress = (data.answers?.length.toDouble() ?? 0);
    print("progress $progress, $totalQuestions, ${data.answers?.length}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _setTileHeader(data),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          onTap: () {
            if (data.uploaded == true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FieldsSetAnsweredPage(
                    answerHolder: data,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FieldsSetPage(formId: data.formId!),
                ),
              );
            }
          },
          title: Text(
            data.formFields?.getName(context.locale.languageCode) ?? "",
            style: TextStyle(color: COLOR_PRIMARY, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.formFields?.category?.getName(context.locale.languageCode) ?? "",
                style: TextStyle(color: Colors.blue),
              )
            ],
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
          /*trailing: FutureBuilder<int>(
            future: countAnswers(data.formId, any: true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                int totalQuestions = 0;
                for (FieldSet item in data.formFields?.fieldSets ?? []) {
                  totalQuestions += item.questionsCount ?? 0;
                }
                double progress = (data.answers?.length.toDouble() ?? 0);
                print("progress $progress, $totalQuestions, ${data.answers?.length}");
                return Stack(
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
                );
                //return Icon(Icons.alarm);
              }
              //return Icon(Icons.local_dining);
              return CircularProgressIndicator();
            },
          ),*/
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  Jiffy(data.completedAt).Hm,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              InkWell(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Consulter ".tr(), style: TextStyle(color: COLOR_PRIMARY)),
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
    );
  }
}
