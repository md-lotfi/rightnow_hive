import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/answers_count.dart';

class FormsDisplayWidget extends StatelessWidget {
  final Function() onTap;
  final FormFields formsFields;
  const FormsDisplayWidget({
    Key? key,
    required this.onTap,
    required this.formsFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AnswersCount answersCount = countAnswersForm(formsFields);
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
        onTap();
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
                if (formsFields.isAnonymous == true)
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
                  margin: formsFields.isAnonymous == true ? (isFrench(context) ? EdgeInsets.only(left: 8) : EdgeInsets.only(right: 8)) : null,
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
              title: Text(formsFields.getName(context.locale.languageCode),
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
              subtitle: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    formsFields.category?.getName(context.locale.languageCode) ?? "",
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
                    formsFields.formatCreatedAt(),
                    //Jiffy.parse(formsFields.createdAt ?? Jiffy.now().format()).yMMMMEEEEd,
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
  }
}
