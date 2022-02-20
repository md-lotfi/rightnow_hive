import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';

import 'package:rightnow/models/AnswersHolder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class AnswerDetailsPage extends StatelessWidget {
  final AnswerHolder answerHolder;
  const AnswerDetailsPage({
    Key? key,
    required this.answerHolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      backgroundColor: Colors.grey.shade100,
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(answerHolder.formFields?.getName(context.locale.languageCode) ?? ""),
        centerTitle: true,
      ),
      //bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX, getDataBase()),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 70,
            child: ScrollTouchWidget(listChild: _addBuilder()),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: TextButton(
              onPressed: () {
                showResponseDialog(context, answerHolder.decisionResponse, () {});
              },
              child: Text("Afficher le résultat".tr()),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _addBuilder() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {},
          dense: true,
          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          title: Text(
            answerHolder.answers?[index].question?.getName(context.locale.languageCode) ?? "",
            style: TextStyle(color: COLOR_PRIMARY, fontSize: 15, fontWeight: FontWeight.normal),
          ),
          subtitle: Text(answerHolder.answers?[index].answerValue ?? ""),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: answerHolder.answers?.length ?? 0,
    );
  }
}
