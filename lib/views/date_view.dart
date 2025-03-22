import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/response_set.dart';

class DateWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final ResponseSet? responseSet;
  final bool viewOnly;

  const DateWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    this.responseSet,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _DateWidgetState createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget>
    with AutomaticKeepAliveClientMixin {
  _DateWidgetState();

  DateTime? _currentDateTime = DateTime.now();
  //DateTime? _selectedDateTime = DateTime.now();

  //bool _hasDate = false;

  @override
  void initState() {
    if (widget.answerHolder != null) {
      if (widget.answerHolder!.answers != null) {
        if (widget.answerHolder!.answers!.length > 0) {
          for (var answer in widget.answerHolder!.answers!) {
            if (answer.qustionId == widget.question!.id) {
              if (isDate(answer.answerValue)) {
                //_hasDate = true;
                _currentDateTime = DateTime.parse(
                    answer.answerValue ?? Jiffy.now().dateTime.toString());
                //_selectedDateTime = _currentDateTime;
              }
            }
          }
        }
      }

      log('setting on selected value init ${Jiffy.parseFromDateTime(_currentDateTime ?? Jiffy.now().dateTime).format(pattern: "yyyy-MM-dd")}');
      widget.onSelectedValue!(
        Answer.fill(
            widget.question?.id,
            widget.question?.fieldSet,
            Jiffy.parseFromDateTime(_currentDateTime ?? Jiffy.now().dateTime)
                .format(pattern: "yyyy-MM-dd"),
            null,
            Jiffy.now(),
            transtypeResourceType(widget.question?.resourcetype),
            widget.answerHolder?.id,
            null),
      );
    } else if (widget.responseSet != null) {
      _currentDateTime = DateTime.parse(
          widget.responseSet?.value ?? Jiffy.now().dateTime.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return load();
  }

  Widget load() {
    DateTime? minDate =
        Jiffy.parse(widget.question?.minValue ?? Jiffy.now().format()).dateTime;
    DateTime? maxDate =
        Jiffy.parse(widget.question?.maxValue ?? Jiffy.now().format()).dateTime;
    if (widget.question?.minValue == null) {
      minDate = null;
    }
    if (widget.question?.maxValue == null) {
      maxDate = null;
    }
    print(context.locale.countryCode);

    //_selectedDateTime = _currentDateTime;
    //log('setting on selected value ${Jiffy(_currentDateTime).format("yyyy-MM-dd")}');
    if (widget.onSelectedValue != null && widget.question != null) {
      widget.onSelectedValue!(
        Answer.fill(
            widget.question!.id,
            widget.question!.fieldSet,
            Jiffy.parseFromDateTime(_currentDateTime ?? Jiffy.now().dateTime)
                .format(pattern: "yyyy-MM-dd"),
            null,
            Jiffy.now(),
            transtypeResourceType(widget.question?.resourcetype),
            widget.answerHolder!.id,
            null),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: FormField<DateTime>(
          autovalidateMode: AutovalidateMode.always,
          initialValue: _currentDateTime,
          builder: (FormFieldState<DateTime> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetQuestionTitle(widget.question,
                    context.locale.languageCode, widget.responseSet),
                if (!widget.viewOnly)
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    margin: EdgeInsets.only(left: 30, right: 30),
                    /*decoration: (!_hasDate
                        ? BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null),*/
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      minimumDate: minDate,
                      maximumDate: maxDate,
                      initialDateTime: _currentDateTime,
                      onDateTimeChanged: (DateTime dateTime) {
                        print("dateTime: " +
                            Jiffy.parseFromDateTime(dateTime)
                                .format(pattern: "yyyy-MM-dd"));
                        //_hasDate = true;
                        //_selectedDateTime = dateTime;
                        _currentDateTime = dateTime;
                        log("date widget view answer value is ${Jiffy.parseFromDateTime(dateTime).format(pattern: "yyyy-MM-dd")}");
                        widget.onSelectedValue!(
                          Answer.fill(
                              widget.question!.id,
                              widget.question!.fieldSet,
                              Jiffy.parseFromDateTime(dateTime)
                                  .format(pattern: "yyyy-MM-dd"),
                              null,
                              Jiffy.now(),
                              transtypeResourceType(
                                  widget.question!.resourcetype!),
                              widget.answerHolder!.id,
                              null),
                        );
                        state.didChange(_currentDateTime);
                        setState(() {});
                      },
                    ),
                  ),
                if (widget.viewOnly)
                  fieldData(Jiffy.parseFromDateTime(
                          _currentDateTime ?? Jiffy.now().dateTime)
                      .format(pattern: "dd/MM/yyyy")),
                Divider(),
                state.errorText == null
                    ? Text("")
                    : Text(state.errorText ?? "",
                        style: TextStyle(color: Colors.red)),
              ],
            );
          },
          validator: (value) {
            if (isRequired(widget.question)) if (_currentDateTime == null)
              return FORM_SELECT_DATE;
            return null;
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
