import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/inherits/field_controller.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';

class IntegerWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const IntegerWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _IntegerWidgetState createState() => _IntegerWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class _IntegerWidgetState extends State<IntegerWidget> with AutomaticKeepAliveClientMixin, FiledController {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  _IntegerWidgetState(this.question, this.answerHolder, this.onSelectedValue);
  @override
  Widget build(BuildContext context) {
    return load();
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
    print("integer text changed " + fieldDataController.text);
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
                  return checkValueValid(
                    value: value,
                    maxValue: question?.maxValue,
                    minValue: question?.minValue,
                    required: isRequired(question),
                  );
                },
                keyboardType: TextInputType.numberWithOptions(
                  decimal: false,
                  signed: true,
                ),
                decoration: InputDecoration(
                  suffixIcon: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (fieldDataController.text.isNotEmpty) {
                            if (isNumeric(fieldDataController.text)) {
                              int i = int.tryParse(fieldDataController.text) ?? 0;
                              fieldDataController.text = (i + 1).toString();
                            }
                          } else {
                            fieldDataController.text = '0';
                          }
                        },
                        child: Icon(Icons.arrow_drop_up),
                      ),
                      InkWell(
                        onTap: () {
                          if (fieldDataController.text.isNotEmpty) {
                            if (isNumeric(fieldDataController.text)) {
                              int i = int.tryParse(fieldDataController.text) ?? 0;
                              fieldDataController.text = (i - 1).toString();
                            }
                          } else {
                            fieldDataController.text = '0';
                          }
                        },
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
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
