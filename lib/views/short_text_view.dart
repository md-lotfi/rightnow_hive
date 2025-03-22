import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/inherits/field_controller.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/response_set.dart';

class ShortTextWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool viewOnly;

  const ShortTextWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _ShortTextWidgetState createState() => _ShortTextWidgetState(
      this.question, this.onSelectedValue, this.answerHolder);
}

class _ShortTextWidgetState extends State<ShortTextWidget>
    with AutomaticKeepAliveClientMixin, FiledController {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  _ShortTextWidgetState(this.question, this.onSelectedValue, this.answerHolder);

  @override
  void initState() {
    fieldDataController.addListener(_dataChanged);
    if (widget.responseSet != null) {
      fieldDataController.text = widget.responseSet?.value ?? " - ";
    } else if (answerHolder != null && question != null) {
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
    print("short text changed " + fieldDataController.text);
    onSelectedValue!(
      Answer.fill(
          question?.id,
          question?.fieldSet,
          fieldDataController.text,
          null,
          Jiffy.now(),
          transtypeResourceType(question?.resourcetype),
          answerHolder?.id,
          null),
    );
    /*if (question.branchedConditions != null) {
      for (var item in question.branchedConditions) {
        if (question.resourcetype == BOOLEAN_QUESTION) {
          //visibility(question.id, (item.value == 'true'));
        }
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return load();
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(
                question, context.locale.languageCode, widget.responseSet),
            if (!widget.viewOnly)
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (!isRequired(question)) return null;
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return FORM_MESSAGES_REQUIRED;
                  }
                },
                controller: fieldDataController,
                keyboardType: TextInputType.text,
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
