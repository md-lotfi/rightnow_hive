import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/search_dropdown.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/choice.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/multiselect_answer.dart';
import 'package:rightnow/models/response_set.dart';

class MultiSelectView extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool viewOnly;
  const MultiSelectView(
      {Key? key,
      this.question,
      this.onSelectedValue,
      this.responseSet,
      this.answerHolder,
      required this.viewOnly})
      : super(key: key);

  @override
  _MultiSelectViewState createState() => _MultiSelectViewState();
}

class _MultiSelectViewState extends State<MultiSelectView>
    with AutomaticKeepAliveClientMixin {
  List<Choice>? _currentChoices;
  List<DropdownMenuItem<Choice>>? _choicesDropdownList;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      if (widget.question != null) {
        setState(() {
          _choicesDropdownList = _dropdownItems();
          if (widget.answerHolder != null) {
            if (widget.answerHolder!.answers != null) {
              if (widget.answerHolder!.answers!.length > 0) {
                for (var answer in widget.answerHolder!.answers!) {
                  if (answer.qustionId == widget.question!.id) {
                    if (answer.multiSelectAnswer != null) {
                      if (answer.multiSelectAnswer!.length > 0) {
                        for (MultiSelectAnswer a
                            in answer.multiSelectAnswer ?? []) {
                          for (Choice choice
                              in widget.question!.choices ?? []) {
                            if (choice.id == a.selectedId) {
                              if (_currentChoices == null) _currentChoices = [];
                              _currentChoices?.add(choice);
                              print(
                                  "setting current choice ${choice.toJson()}");
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
      }
    });
    super.initState();
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
            widgetQuestionTitle(widget.question!, context.locale.languageCode,
                widget.responseSet),
            if (!widget.viewOnly)
              /*Expanded(
                child: */
              FormField(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _currentChoices,
                builder: (FormFieldState<List<Choice>> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_currentChoices == null)
                        _showSelect(state, () {
                          return Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            width: double.infinity,
                            height: 45,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 0.80,
                                  color:
                                      (widget.answerHolder?.answers?.length ??
                                                  0) ==
                                              0
                                          ? Colors.grey.shade300
                                          : (_currentChoices == null
                                              ? Colors.red
                                              : Colors.grey.shade300)),
                            ),
                            child: Icon(Icons.arrow_drop_down),
                          );
                        }),
                      if (_currentChoices != null)
                        _showSelect(state, () {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            width: double.infinity,
                            //height: 45,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  width: 0.80,
                                  color:
                                      (widget.answerHolder?.answers?.length ??
                                                  0) ==
                                              0
                                          ? Colors.grey.shade300
                                          : (_currentChoices == null
                                              ? Colors.red
                                              : Colors.grey.shade300)),
                            ),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (Choice item in _currentChoices ?? [])
                                        Container(
                                          child: Text(item.getName(
                                              context.locale.languageCode)),
                                        ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      state.errorText == null
                          ? Text("")
                          : Text(state.errorText ?? "",
                              style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(widget.question)) if (_currentChoices == null)
                    return FORM_LIST_NOT_SELECTED;
                  return null;
                },
              ),
            //),
            //if (widget.viewOnly) Text("multiselect view"),
            //if (widget.viewOnly) fieldDataMultiLine(_currentChoices?.map((e) => e.getName(context.locale.languageCode)).toList()),
            if (widget.viewOnly)
              fieldData(widget.responseSet
                      ?.getChoice()
                      ?.getName(context.locale.languageCode) ??
                  ""),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _showSelect(
      FormFieldState<List<Choice>> state, Widget Function() builder) {
    return SearchableDropdown<Choice>(
      defaultValues: _currentChoices,
      items: widget.question!.choices ?? [],
      dialogTitle: "Choisir une ou plusieurs options".tr(),
      builder: () {
        return builder();
      },
      itemBuilder: (index, d) {
        return d.getName(context.locale.languageCode);
        /*return ListTile(
                      title: Text(d.getName(context.locale.languageCode)), //getName(context.locale.languageCode)
                    );*/
      },
      searchBuilder: (items, search) {
        return items
            .where((element) => element
                .getName(context.locale.languageCode)
                .toLowerCase()
                .contains(search.toLowerCase()))
            .toList();
      },
      onSelected: (selectedValue) {
        print("on selected result 1 $selectedValue");
        List<MultiSelectAnswer> m = [];
        for (var item in selectedValue) {
          m.add(MultiSelectAnswer.fill(
              widget.answerHolder?.id, item.id, item.label));
        }
        //m.add(MultiSelectAnswer.fill(widget.answerHolder?.id, _currentChoice!.id, _currentChoice!.label));
        _currentChoices = selectedValue;
        state.didChange(_currentChoices);
        print("on selected result 2 $selectedValue");
        widget.onSelectedValue!(
          Answer.fill(
            widget.question!.id,
            widget.question!.fieldSet,
            "",
            null,
            Jiffy.now(),
            transtypeResourceType(widget.question!.resourcetype!),
            widget.answerHolder?.id,
            m,
          ),
        );
        print("on selected result 3 $selectedValue");
      },
    );
  }

  List<DropdownMenuItem<Choice>> _dropdownItems() {
    List<DropdownMenuItem<Choice>> l = [];
    if (widget.question!.choices != null) {
      if (widget.question!.choices!.length > 0) {
        for (var choice in widget.question!.choices!) {
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
