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

class SelectWidget extends StatefulWidget {
  final Question question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const SelectWidget({
    Key? key,
    required this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);

  @override
  _SelectWidgetState createState() => _SelectWidgetState(this.answerHolder, this.onSelectedValue);
}

class _SelectWidgetState extends State<SelectWidget> with AutomaticKeepAliveClientMixin {
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  _SelectWidgetState(this.answerHolder, this.onSelectedValue);
  Choice? _currentChoice;
  List<DropdownMenuItem<Choice>>? _choicesDropdownList;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      setState(() {
        _choicesDropdownList = _dropdownItems();
        if (answerHolder != null) {
          if (answerHolder!.answers != null) {
            if (answerHolder!.answers!.length > 0) {
              for (var answer in answerHolder!.answers!) {
                if (answer.qustionId == widget.question.id) {
                  if (answer.multiSelectAnswer != null) {
                    if (answer.multiSelectAnswer!.length > 0) {
                      for (var choice in _choicesDropdownList!) {
                        if (choice.value != null) {
                          if (choice.value!.id == answer.multiSelectAnswer![0].selectedId) {
                            setState(() {
                              _currentChoice = choice.value;
                              print("setting current choice ${choice.value?.toJson().toString()}");
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
        }
      });
    });
    /*if (_choicesDropdownList.length > 0) {
      _currentChoice = _choicesDropdownList[0].value;
    }*/

    /*setState(() {
      _currentChoice = _dropdownItems();
    });*/
    super.initState();
  }

  _setOnSeletedValue() {
    List<MultiSelectAnswer> m = [];
    m.add(MultiSelectAnswer.fill(answerHolder?.id, _currentChoice!.id, _currentChoice!.label));
    onSelectedValue!(
      Answer.fill(
        widget.question.id,
        widget.question.fieldSet,
        _currentChoice!.label,
        _currentChoice!.id.toString(),
        DateTime.now().toString(),
        transtypeResourceType(widget.question.resourcetype!),
        answerHolder?.id,
        m,
      ),
    );
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(widget.question, context.locale.languageCode),
            if (!widget.viewOnly)
              FormField<Choice>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _currentChoice,
                builder: (FormFieldState<Choice> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              style: BorderStyle.solid,
                              width: 0.80,
                              color: (answerHolder?.answers?.length ?? 0) == 0 ? Colors.grey.shade300 : (_currentChoice == null ? Colors.red : Colors.grey.shade300)),
                        ),
                        child: DropdownButton(
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 42,
                          underline: SizedBox(),
                          isExpanded: true,
                          value: _currentChoice,
                          items: _choicesDropdownList,
                          onChanged: (value) {
                            changedDropDownItem(value as Choice, state);
                          },
                        ),
                      ),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) if (_currentChoice == null) return FORM_LIST_NOT_SELECTED;
                  return null;
                },
              ),
            if (widget.viewOnly) fieldData(_currentChoice?.getName(context.locale.languageCode) ?? ""),
            Divider(),
          ],
        ),
      ),
    );
  }

  void changedDropDownItem(Choice? choice, FormFieldState<Choice> state) {
    setState(() {
      _currentChoice = choice;
      _setOnSeletedValue();
      state.didChange(_currentChoice);
    });
  }

  List<DropdownMenuItem<Choice>> _dropdownItems() {
    List<DropdownMenuItem<Choice>> l = [];
    if (widget.question.choices != null) {
      if (widget.question.choices!.length > 0) {
        for (var choice in widget.question.choices!) {
          l.add(DropdownMenuItem(
            value: choice,
            child: Text(choice.getName(context.locale.languageCode)),
          ));
        }
      }
    }
    return l;
  }

  @override
  bool get wantKeepAlive => true;
}
