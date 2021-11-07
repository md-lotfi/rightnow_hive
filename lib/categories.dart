import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/category_dao.dart';
import 'package:rightnow/forms.dart';
import 'package:rightnow/history_screen.dart';
import 'package:rightnow/models/category.dart';
import 'package:rightnow/models/super_category.dart';
import 'package:rightnow/screen_viewer.dart';

class CategoriesPage extends StatelessWidget {
  final SuperCategory superCategory;
  const CategoriesPage({
    Key? key,
    required this.superCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text(superCategory.title(context.locale.languageCode)), //"Check-up center".tr()
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
              },
              icon: Icon(Icons.history))
        ],
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_FORMS_INDEX),
      backgroundColor: Colors.grey.shade50,
      body: _body(),
    ));
  }

  Widget _body() {
    return FutureBuilder<List<Category>>(
      future: getDataBase<CategoryDao>().fetchCategoriesOfSuperCategory(superCategory.id ?? -1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: _loader(snapshot.data ?? []),
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
            trailing: cats[index].icon == null ? Image.network(cats[index].icon!) : null,
          ),
        );
      },
    );
  }
}
