import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/response_set.dart';

class BooleanWidget extends StatefulWidget {
  final Question? question;
  final ResponseSet? responseSet;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const BooleanWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _BooleanWidgetState createState() => _BooleanWidgetState(this.onSelectedValue, this.answerHolder);
}

class _BooleanWidgetState extends State<BooleanWidget> with AutomaticKeepAliveClientMixin {
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  String? _radioValue;

  _BooleanWidgetState(this.onSelectedValue, this.answerHolder);

  bool _hasData = false;

  @override
  void initState() {
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            //print("answer is ${answer.qustionId}, ${widget.question.id} *********************");
            if (widget.question != null) {
              if (answer.qustionId == widget.question!.id) {
                _radioValue = answer.answerValue;
                print("boolean is $_radioValue *********************");
                break;
              }
            }
          }
        }
      }
      setState(() {
        if (_radioValue == null) _radioValue = "false";
        _hasData = true;
        _setSelected();
      });
    } else if (widget.responseSet != null) {
      _radioValue = widget.responseSet?.value.toString() ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        //unselectedWidgetColor: (answerHolder?.answers?.length ?? 0) == 0 ? null : (_radioValue == null ? Colors.red : null),
        unselectedWidgetColor: _hasData ? null : (_radioValue == null ? Colors.red : null),
      ),
      child: load(),
    );
  }

  //RadioboxWidget(this.question);

  _setSelected() {
    if (onSelectedValue != null && widget.question != null) {
      onSelectedValue!(
        Answer.fill(widget.question?.id, widget.question?.fieldSet, _radioValue, null, DateTime.now().toString(), transtypeResourceType(widget.question?.resourcetype), answerHolder?.id, null),
      );
    }
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(widget.question, context.locale.languageCode, widget.responseSet),
            if (!widget.viewOnly)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: "true",
                    groupValue: _radioValue,
                    onChanged: (String? value) {
                      setState(() {
                        _radioValue = value;
                        _setSelected();
                        //onSelectedValue()
                      });
                    },
                  ),
                  Text("Yes".tr()),
                  Radio(
                    value: "false",
                    groupValue: _radioValue,
                    onChanged: (String? value) {
                      setState(() {
                        _radioValue = value;
                        _setSelected();
                      });
                    },
                  ),
                  Text("No".tr()),
                ],
              ),
            if (widget.viewOnly) fieldData(_radioValue == 'true' ? "Yes".tr() : "No".tr()),
            Divider(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
