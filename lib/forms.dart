import 'dart:developer';

import 'package:flutter/foundation.dart' as kIsWeb;
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/FormsDescription.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/category_display_widget.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/forms_display_widget.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/components/search_text_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/HashDao.dart';
import 'package:rightnow/db/category_dao.dart';
import 'package:rightnow/db/sub_category_dao.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/answers_count.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/models/sub_category.dart';
import 'package:rightnow/models/super_category.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class FormsPage extends StatefulWidget {
  final Category? category;
  final SubCategory? subCategory;
  final SuperCategory? superCategory;
  const FormsPage({Key? key, this.superCategory, this.category, this.subCategory}) : super(key: key);

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
                NavState.NAV_HOME,
              ),
              backgroundColor: Colors.grey.shade50,
              body: _body(
                  []), /*FutureBuilder<List<Category>>(
                future: getDataBase<CategoryDao>().fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return _body(snapshot.data ?? []);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              )*/

              //_checkLoad(),
            ),
            onWillPop: () async {
              return true;
            })); //showExitPopup
  }

  String _getCatName() {
    return widget.superCategory != null
        ? widget.superCategory!.title(context.locale.languageCode)
        : (widget.category != null ? widget.category!.getName(context.locale.languageCode) : (widget.subCategory!.getName(context.locale.languageCode)));
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
                            //"Check-up center".tr(),
                            _getCatName(),
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
      //return Container();
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
    //return Container();
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
    dynamic cat = widget.category ?? widget.superCategory ?? widget.subCategory;
    assert(cat != null);
    return FutureBuilder<List<FormFields>>(
      future: getDataBase<FormFieldsDao>()
          .fetchFormsAnyCategory(cat, context), //getDataBase<FormFieldsDao>().loadFormsCategoryId(context, widget.category.id, HOLDER_NOT_COMPLETED, searchFormTitle: _searchText),
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
        child: _builder(context, data),
        margin: EdgeInsets.only(left: 20, right: 20, top: kIsWeb.kIsWeb ? 20 : 0),
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

  Widget _builder(BuildContext context, List<FormFields> forms) {
    return ScrollTouchWidget(
      listChild: ListView.separated(
        separatorBuilder: (context, index) {
          return Container(
            height: 20,
          );
        },
        //shrinkWrap: true,
        itemCount: forms.length,
        itemBuilder: (context, index) {
          return FormsDisplayWidget(
              onTap: () {
                if (forms[index].getDescription(context.locale.languageCode).isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormsDescription(
                        form: forms[index],
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
                        formId: forms[index].id!,
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                }
              },
              formsFields: forms[index]);
        },
      ),
    );
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
