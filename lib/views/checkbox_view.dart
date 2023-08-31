import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/choice.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:collection/collection.dart';
import 'package:rightnow/models/response_set.dart';

class CheckboxWidget extends StatefulWidget {
  final Question? question;
  final ResponseSet? responseSet;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const CheckboxWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> with AutomaticKeepAliveClientMixin {
  Map<int, bool> _values = {};

  Choice? _selectedAnswer;
  bool _hasData = false;

  _CheckboxWidgetState();

  bool _isChecked(Choice? choice) {
    if (choice == null) return false;
    if (_values.containsKey(choice.id)) {
      bool x = _values[choice.id] ?? false;
      print("multiselect length checking choice ${choice.id}, ${_values[choice.id]}, ${_values.containsKey(choice.id)}, $x");
      return x;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.question != null) {
      for (var i = 0; i < widget.question!.choices!.length; i++) {
        _values[widget.question!.choices![i].id!] = false;
      }
    }
    if (widget.answerHolder != null) {
      if (widget.answerHolder!.answers != null) {
        if (widget.answerHolder!.answers!.length > 0) {
          for (var answer in widget.answerHolder!.answers!) {
            log("checkbox selected answer not null ${answer.qustionId} and ${widget.question!.id}");
            if (answer.qustionId == widget.question!.id) {
              if (answer.multiSelectAnswer != null) {
                if (answer.multiSelectAnswer!.length > 0) {
                  log("multiselect length ${answer.multiSelectAnswer?.length}");
                  for (var m in answer.multiSelectAnswer ?? []) {
                    log("checkbox selected multiselect ${m.selectedId}");
                    for (Choice choice in widget.question!.choices ?? []) {
                      if (choice.id == m.selectedId) {
                        _values[choice.id!] = true;
                        _hasData = true;
                        _selectedAnswer = choice;
                      }
                      //print("multiselect length and choice ${_values[choice.id!]}, ${choice.id == m.selectedId}, ${choice.id}, ${m.selectedId}");
                    }
                  }
                  /*for (var choice in widget.question!.choices!) {
                        _values[choice.id!] = (choice.id == answer.multiSelectAnswer![0].selectedId);
                        if (choice.id == answer.multiSelectAnswer![0].selectedId) _selectedAnswer = choice.getName(context.locale.languageCode);
                      }*/
                }
              }
            }
          }
        }
      }
    }
    /*if (_selectedAnswer != null) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        _selectedAnswer = choice.getName(context.locale.languageCode);
      });
    }*/
    print("multiselect length result $_values");
    //_setOnSelectedValue();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: (widget.answerHolder?.answers?.length ?? 0) == 0 ? null : (_values.values.contains(true) ? null : Colors.red),
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
            widgetQuestionTitle(widget.question, context.locale.languageCode, widget.responseSet),
            if (!widget.viewOnly)
              FormField<Map<int, bool>>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _values,
                builder: (FormFieldState<Map<int, bool>> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._checkboxes(state),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (val) {
                  if (isRequired(widget.question)) {
                    var l = _values.values.firstWhereOrNull((element) => element == true);
                    if (l == null) return FORM_CHECKBOX_NOT_SELECTED;
                    return null;
                  }
                },
              ),
            //if (widget.viewOnly) Text("ceheck box view"),
            //if (widget.viewOnly) fieldData(_selectedAnswer?.getName(context.locale.languageCode)),
            if (widget.viewOnly) fieldData(widget.responseSet?.getChoice()?.getName(context.locale.languageCode) ?? ""),
            Divider(),
          ],
        ),
      ),
    );
  }

  _setOnSelectedValue() {
    if (widget.answerHolder == null) return;
    List<MultiSelectAnswer> m = [];
    for (var v in widget.question!.choices!) {
      if (_values[v.id] != null) {
        if (_values[v.id] == true) m.add(MultiSelectAnswer.fill(widget.answerHolder?.id, v.id, v.label));
      }
    }
    if (widget.onSelectedValue != null) {
      print("multiselect length result ${m.length}");
      widget.onSelectedValue!(
        Answer.fill(widget.question?.id, widget.question?.fieldSet, "", null, DateTime.now().toString(), transtypeResourceType(widget.question?.resourcetype), widget.answerHolder?.id, m),
      );
    }
  }

  List<Widget> _checkboxes(FormFieldState<Map<int, bool>> state) {
    List<Widget> l = [];
    if (widget.question!.choices != null) {
      if (widget.question!.choices!.length > 0) {
        for (var choice in widget.question!.choices!) {
          l.add(
            Row(
              //alignment: WrapAlignment.start,
              //crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Checkbox(
                  //tristate: true,
                  value: _isChecked(choice),
                  //value: (_values.keys.firstWhereOrNull((element) => element == choice.id)) != null ? _values[choice.id] : false,
                  onChanged: (bool? value) {
                    print("multiselect length onChnage $value");
                    setState(() {
                      _values[choice.id!] = value ?? false;
                      _setOnSelectedValue();
                      state.didChange(_values);
                    });
                  },
                ),
                Text(choice.getName(context.locale.languageCode))
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
