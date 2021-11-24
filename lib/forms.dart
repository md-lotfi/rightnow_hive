import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/FormsDescription.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/components/search_text_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/answers_count.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class FormsPage extends StatefulWidget {
  final Category category;
  const FormsPage({Key? key, required this.category}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<FormsPage> {
  //AnswerHolder activeAnswerHolder;
  //List<AnswerHolder> waitingUploadAnswerHolder = [];

  bool _checkServer = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _checkData();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: WillPopScope(
            child: Scaffold(
              bottomNavigationBar: HomeNavBarComp(
                NavState.NAV_FORMS_INDEX,
              ),
              backgroundColor: Colors.grey.shade50,
              body: FutureBuilder<List<Category>>(
                future: getDataBase<FormFieldsDao>().fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _body(snapshot.data ?? []);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              //_checkLoad(),
            ),
            onWillPop: () async {
              return true;
            })); //showExitPopup
  }

  Widget _body(List<Category> categories) {
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
                      Expanded(
                        child: SearchTextWidget(
                          staticWidget: Text(
                            "Check-up center".tr(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20), color: COLOR_PRIMARY),
                          ),
                          onSearch: (searchText) {
                            print("search text is $searchText");
                            setState(() {
                              _searchText = searchText;
                            });
                          },
                        ),

                        /*Text(
                          "Check-up center".tr(),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 20), color: COLOR_PRIMARY),
                        ),*/
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
                  /*SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: ListView.separated(
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
                  ),*/
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: _checkLoad(),
        ),
      ],
    );
  }

  Widget _checkLoad() {
    if (_checkServer) {
      ApiRepository api = ApiRepository();
      _checkServer = false;
      return FutureBuilder<Hashes?>(
        future: api.fetchHashRaw(type: HASH_TYPE_CATEGORIES),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return FutureBuilder<Widget>(
                future: saveAndStatCategoriesPage(snapshot.data!),
                builder: (context, snapshot) {
                  if (ConnectionState.done == snapshot.connectionState) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    } else {
      //BlocProvider.of<FormsBloc>(context).add(FormsEvent.loadLocalForms());
      return _bloc();
      //return Container();
    }
  }

  Future<Widget> saveAndStatCategoriesPage(Hashes data) async {
    bool newForms = true;
    var result = await getDataBase<HashDao>().fetchHashesByType(HASH_TYPE_CATEGORIES);

    if (result != null) {
      print("data received " + data.hash!);
      if (result.hash != null) {
        print("data hash is " + result.hash!);
        if (data.hash == result.hash) {
          newForms = false;
        }
      }
    }
    return startCategoriesPage(newForms, data.hash!);
  }

  Future<Widget> startCategoriesPage(bool loadNew, String currentHash) async {
    if (loadNew) {
      ApiRepository api = ApiRepository();
      print("loading new page");
      List<FormFields>? f = await api.fetchFormFieldsRaw();
      await getDataBase<FormFieldsDao>().setForms(f ?? [], new Hashes.fill(currentHash, HASH_TYPE_CATEGORIES));
      //BlocProvider.of<FormsBloc>(context).add(FormsEvent.loadLocalForms());
      //BlocProvider.of<HashBloc>(context).add(HashEvent.loadCategories(currentHash));
    }
    //return Container();
    return _bloc();
  }

  Widget _bloc() {
    return FutureBuilder<List<FormFields>>(
      future: getDataBase<FormFieldsDao>().loadFormsCategoryId(context, widget.category.id, searchFormTitle: _searchText),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _dataWidget(snapshot.data!);
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _dataWidget(List<FormFields> data) {
    return Center(
        child: RefreshIndicator(
      child: Container(
        //color: Colors.red,
        child: _builder(data),
        margin: EdgeInsets.only(left: 20, right: 20),
      ),
      onRefresh: () async {
        setState(() {
          _checkServer = true;
        });
        return await Future.delayed(
          Duration(seconds: 3),
        );
      },
    ));
  }

  Widget _builder(List<FormFields> data) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 20,
        );
      },
      //shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        AnswersCount answersCount = countAnswersForm(data[index]);
        /*int totalQuestions = 0;
        int realTotalQuestions = 0;
        for (FieldSet item in data[index].fieldSets ?? []) {
          realTotalQuestions += countActiveQuestions(item);
          totalQuestions += countQuestions(item);
        }*/
        double time = (answersCount.totalQuestions * 10) / 60;
        int fx = 0;
        if (time > 0) fx = time.ceil();

        //double progress = ((data[index].answerHolder?.answers?.length ?? 0).toDouble());
        return InkWell(
          onTap: () {
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              if (data[index].getDescription(context.locale.languageCode).isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormsDescription(
                      form: data[index],
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    _checkData();
                  });
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FieldsSetPage(
                      formId: data[index].id!,
                    ),
                  ),
                ).then((value) {
                  setState(() {});
                });
              }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (data[index].isAnonymous == true)
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: isFrench(context) ? EdgeInsets.only(left: 8) : EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Anonyme".tr(),
                          style: TextStyle(color: Colors.white, backgroundColor: Colors.black, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10)),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: data[index].isAnonymous == true ? (isFrench(context) ? EdgeInsets.only(left: 8) : EdgeInsets.only(right: 8)) : null,
                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "$fx min".tr(),
                        style: TextStyle(color: Colors.white, backgroundColor: Colors.blue, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10)),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  title: Text(data[index].getName(context.locale.languageCode),
                      style: TextStyle(color: COLOR_PRIMARY, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 16), fontWeight: FontWeight.bold)),
                  trailing: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        answersCount.realTotalQuestions.toString(), //progress.floor().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        color: answersCount.totalQuestions == 0 ? Colors.grey : ((answersCount.progress) < 1 ? Colors.red : Colors.green),
                        value: answersCount.totalQuestions == 0 ? 0 : (answersCount.progress),
                      ),
                    ],
                  ),
                  /*FutureBuilder<int>(
                    future: countAnswers(data[index].id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        double progress = ((snapshot.data ?? 0).toDouble());
                        //Map<String, dynamic> _prog = _progress(data[index].fieldSets ?? [], snapshot.data ?? 0);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              totalQuestions.toString(), //progress.floor().toString(),
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
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        data[index].category?.getName(context.locale.languageCode) ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Jiffy(data[index].createdAt).yMMMMEEEEd,
                        style: TextStyle(color: Colors.grey),
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    /*return GridView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {
            SchedulerBinding.instance!.addPostFrameCallback((_) {
              if (data[index].getDescription(context.locale.languageCode).isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormsDescription(
                      form: data[index],
                    ),
                  ),
                ).then((value) {
                  setState(() {
                    _checkData();
                  });
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FieldsSetPage(
                      formFields: data[index],
                    ),
                  ),
                );
              }
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
                        child: loadImage(
                          data[index].icon,
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

  Future<bool> showExitPopup() async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirmation'.tr()),
            content: Text("Voulez-vous quitter l'application?".tr()),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return false when click on "NO"
                child: Text('Oui'.tr()),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return true when click on "Yes"
                child: Text('Non'.tr()),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  _checkData() {}
}
