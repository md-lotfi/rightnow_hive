import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/multiselect_answer.dart';

class RadioboxWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const RadioboxWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _RadioboxWidgetState createState() => _RadioboxWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class _RadioboxWidgetState extends State<RadioboxWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  int? _checkValue;

  String? _selectedAnswer;

  _RadioboxWidgetState(this.question, this.answerHolder, this.onSelectedValue);

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        if (answerHolder != null) {
          if (answerHolder!.answers != null) {
            log("radiobow selected answer not null ${answerHolder!.answers!.length}");
            if (answerHolder!.answers!.length > 0) {
              for (var answer in answerHolder!.answers!) {
                log("radiobow selected answer not null ${answer.qustionId} and ${question!.id}");
                if (answer.qustionId == question!.id) {
                  if (answer.multiSelectAnswer != null) {
                    if (answer.multiSelectAnswer!.length > 0) {
                      for (var choice in question!.choices!) {
                        log("radiobow selected answer first ${answer.multiSelectAnswer![0].selectedId}");
                        if (choice.id == answer.multiSelectAnswer![0].selectedId) {
                          setState(() {
                            _checkValue = choice.id!;
                            _selectedAnswer = choice.getName(context.locale.languageCode);
                            log("radiobow selected answer $_selectedAnswer");
                          });
                          break;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        _checkValue = -1;
      });
    });
    super.initState();
  }

  String _getChoiceLabel() {
    for (var item in question!.choices!) {
      if (item.id == _checkValue) return item.label!;
    }
    return "";
  }

  _setOnSeletedValue() {
    List<MultiSelectAnswer> m = [];
    m.add(MultiSelectAnswer.fill(answerHolder!.id, _checkValue, _getChoiceLabel()));
    onSelectedValue!(Answer.fill(question!.id, question!.fieldSet, _checkValue.toString(), null, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!), answerHolder!.id, m));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: (answerHolder?.answers?.length ?? 0) == 0 ? null : (_checkValue != 0 ? null : Colors.red),
      ),
      child: load(),
    );
  }

  Widget load() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(question!, context.locale.languageCode),
            if (!widget.viewOnly)
              FormField(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _checkValue,
                builder: (FormFieldState<int> state) {
                  return Column(
                    children: [
                      Wrap(
                        //alignment: WrapAlignment.start,
                        children: _checkboxes(state),
                      ),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) if (_checkValue == null) return FORM_RADIO_NOT_SELECTED;
                  return null;
                },
              ),
            if (widget.viewOnly) Text("radio box view"),
            if (widget.viewOnly) fieldData(_selectedAnswer),
            Divider(),
          ],
        ),
      ),
    );
  }

  List<Widget> _checkboxes(FormFieldState<int> state) {
    List<Widget> l = [];
    if (question!.choices != null) {
      if (question!.choices!.length > 0) {
        for (var choice in question!.choices!) {
          l.add(
            Row(
              //crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Radio<int?>(
                  groupValue: _checkValue,
                  value: choice.id,
                  onChanged: (int? value) {
                    setState(() {
                      _checkValue = value!;
                      _setOnSeletedValue();
                      state.didChange(value);
                    });
                  },
                ),
                Expanded(child: Text(choice.getName(context.locale.languageCode))),
              ],
            ),
          );
        }
      }
    }
    return l;
  }

  @override
  bool get wantKeepAlive => true;
}
