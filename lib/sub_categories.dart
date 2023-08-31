import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/FormsDescription.dart';

import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/category_display_widget.dart';
import 'package:rightnow/components/forms_display_widget.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/db/category_dao.dart';
import 'package:rightnow/db/sub_category_dao.dart';
import 'package:rightnow/fieldsets.dart';
import 'package:rightnow/forms.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/sub_category.dart';
import 'package:rightnow/questions_screen.dart';
import 'package:rightnow/screen_viewer.dart';

class SubCategoriesPage extends StatelessWidget {
  final Category category;
  const SubCategoriesPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text(category.getName(context.locale.languageCode)), //"Check-up center".tr()
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
              },
              icon: Icon(Icons.history))
        ],
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      backgroundColor: Colors.grey.shade50,
      body: _body(context),
    ));
  }

  Widget _body(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getDataBase<SubCategoryDao>().fetchSubCategoriesOfCategory(context, category.id ?? -1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: ScrollTouchWidget(listChild: _loader(context, snapshot.data ?? {})), //snapshot.data ?? []
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _loader(BuildContext context, Map<String, dynamic> cats) {
    if (cats.isEmpty) return Container();
    List<Widget> l = [];
    for (SubCategory item in cats['categories'] ?? []) {
      l.add(
        CategoryDisplayWidget(
          title: item.getName(context.locale.languageCode),
          icon: item.icon,
          onTap: () async {
            //Category? c = await getDataBase<CategoryDao>().getCategory(item.categoryId!);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormsPage(
                    subCategory: item,
                  ),
                ));
          },
        ),
      );
    }
    for (FormFields item in cats['forms'] ?? []) {
      l.add(
        FormsDisplayWidget(
            onTap: () async {
              if (item.getDescription(context.locale.languageCode).isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormsDescription(
                      form: item,
                    ),
                  ),
                ).then((value) {
                  /*setState(() {
                      _checkData();
                    });*/
                });
              } else {
                FormFields ff = await getDataBase<FormFieldsDao>().loadFormFieldSets(item.id!, HOLDER_NOT_COMPLETED);
                log("field set length: ${ff.fieldSets?.length}");
                if (ff.fieldSets?.length == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionsPage(
                        //key: MyApp.fileWidgetState,
                        key: UniqueKey(),
                        fieldSet: ff.fieldSets![0],
                        anonymous: item.isAnonymous ?? false,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FieldsSetPage(
                        formId: item.id!,
                      ),
                    ),
                  ).then((value) {
                    //setState(() {});
                  });
                }
              }
            },
            formsFields: item),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 20,
        );
      },
      itemCount: l.length,
      itemBuilder: (context, index) {
        return l[index];
        //log("categories ${cats[index].toJson().toString()}");
        /*for (Category item in cats['categories'] ?? []) {
          return CategoryDisplayWidget(
            title: item.getName(context.locale.languageCode),
            icon: item.icon,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormsPage(
                      category: item,
                    ),
                  ));
            },
          );
        }
        for (FormFields item in cats['forms'] ?? []) {
          return FormsDisplayWidget(
              onTap: () {
                if (item.getDescription(context.locale.languageCode).isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormsDescription(
                        form: item,
                      ),
                    ),
                  ).then((value) {
                    /*setState(() {
                      _checkData();
                    });*/
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FieldsSetPage(
                        formId: item.id!,
                      ),
                    ),
                  ).then((value) {
                    //setState(() {});
                  });
                }
              },
              formsFields: item);
        }
        return Container();*/
      },
    );
  }

  /*Widget _body() {
    return FutureBuilder<List<Category>>(
      future: getDataBase<CategoryDao>().fetchCategoriesOfSuperCategory(superCategory.id ?? -1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: ScrollTouchWidget(listChild: _loader(snapshot.data ?? [])),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _loader(List<Category> cats) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          height: 20,
        );
      },
      itemCount: cats.length,
      itemBuilder: (context, index) {
        //log("categories ${cats[index].toJson().toString()}");
        return Container(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
          decoration: BoxDecoration(
            color: COLOR_PRIMARY,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormsPage(
                      category: cats[index],
                    ),
                  ));
            },
            title: Text(
              cats[index].getName(context.locale.languageCode),
              style: TextStyle(color: Colors.white),
            ),
            trailing: cats[index].icon != null ? Image.network(cats[index].icon!) : null,
          ),
        );
      },
    );
  }*/
}
