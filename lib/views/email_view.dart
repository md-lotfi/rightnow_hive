import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/inherits/field_controller.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';

class EmailWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const EmailWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _EmailWidgetState createState() => _EmailWidgetState(this.question, this.onSelectedValue, this.answerHolder);
}

class _EmailWidgetState extends State<EmailWidget> with AutomaticKeepAliveClientMixin, FiledController {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

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
    print("email text changed " + fieldDataController.text);
    onSelectedValue!(
      Answer.fill(question!.id, question!.fieldSet, fieldDataController.text, null, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder!.id, null),
    );
  }

  _EmailWidgetState(this.question, this.onSelectedValue, this.answerHolder);
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
            widgetQuestionTitle(question!, context.locale.languageCode),
            if (!widget.viewOnly)
              TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  return checkEmailValueValid(required: isRequired(question), value: value);
                },
                controller: fieldDataController,
                keyboardType: TextInputType.emailAddress,
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
