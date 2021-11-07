import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/inherits/field_controller.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';

class FreeTextWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const FreeTextWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _FreeTextWidgetState createState() => _FreeTextWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class _FreeTextWidgetState extends State<FreeTextWidget> with AutomaticKeepAliveClientMixin, FiledController {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  _FreeTextWidgetState(this.question, this.answerHolder, this.onSelectedValue);
  @override
  Widget build(BuildContext context) {
    return load();
    /*return new Theme(
        data: new ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: load());*/
  }

  @override
  void initState() {
    fieldDataController.addListener(_dataChanged);
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            if (answer.qustionId == question!.id) {
              fieldDataController.text = answer.answerValue!;
            }
          }
        }
      }
    }
    super.initState();
  }

  _dataChanged() {
    print("decimal text changed " + fieldDataController.text);
    onSelectedValue!(
      Answer.fill(question!.id, question!.fieldSet, fieldDataController.text, null, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder!.id, null),
    );
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(question!, context.locale.languageCode),
            if (!widget.viewOnly)
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                controller: fieldDataController,
                validator: (value) {
                  if (!isRequired(question)) return null;
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return FORM_MESSAGES_REQUIRED;
                  }
                },
                maxLines: 20,
                minLines: 4,
                maxLength: question?.maxLength,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      //borderSide: (answerHolder?.answers?.length ?? 0) == 0 ? BorderSide() : (fieldDataController.text.isEmpty ? BorderSide(color: Colors.red) : BorderSide()),
                      ),
                  focusedBorder: OutlineInputBorder(
                      //borderSide: BorderSide(), //(fieldDataController.text.isEmpty ? BorderSide(color: Colors.red) : BorderSide()),
                      ),
                  border: OutlineInputBorder(
                      //borderSide: BorderSide(), //(fieldDataController.text.isEmpty ? BorderSide(color: Colors.red) : BorderSide()),
                      ),
                ),
              ),
            if (widget.viewOnly) fieldData(fieldDataController.text),
            Divider(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
