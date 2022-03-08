import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';

class TimeWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const TimeWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _TimeWidgetState createState() => _TimeWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class _TimeWidgetState extends State<TimeWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  DateTime _currentDateTime = DateTime.now();
  DateTime? _selectedDateTime = DateTime.now();

  bool _hasDate = false;

  _TimeWidgetState(this.question, this.answerHolder, this.onSelectedValue);
  @override
  Widget build(BuildContext context) {
    return load();
  }

  @override
  void initState() {
    _currentDateTime = DateTime.now();
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            if (answer.qustionId == question!.id) {
              if (answer.answerValue != null) {
                String d = '1970-01-01 ' + answer.answerValue! + ":00";
                //print("time is ${Jiffy(d).dateTime}");
                if (isDate(d)) {
                  _hasDate = true;
                  _currentDateTime = DateTime.parse(d);
                }
              }
            }
          }
        }
      }
    }
    super.initState();
  }

  Widget load() {
    DateFormat df = DateFormat('HH:mm:ss');
    DateTime? minTime = df.parse(question?.minValue ?? "00:00:00");
    DateTime? maxTime = df.parse(question?.maxValue ?? "00:00:00");
    String t = Jiffy(_currentDateTime).format("HH:mm");
    _selectedDateTime = _currentDateTime;
    print("selected time: $t");
    onSelectedValue!(
      Answer.fill(question!.id, question!.fieldSet, t, null, t, transtypeResourceType(question!.resourcetype!), answerHolder!.id, null),
    );
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widgetQuestionTitle(question!, context.locale.languageCode),
            if (!widget.viewOnly)
              FormField<DateTime>(
                autovalidateMode: AutovalidateMode.always,
                initialValue: _selectedDateTime,
                builder: (FormFieldState<DateTime> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        margin: EdgeInsets.only(left: 30, right: 30),
                        decoration: (answerHolder?.answers?.length ?? 0) == 0
                            ? null
                            : (!_hasDate
                                ? BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(8),
                                  )
                                : null),
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          //minimumDate: minTime,
                          //maximumDate: maxTime,
                          initialDateTime: _currentDateTime,
                          onDateTimeChanged: (DateTime dateTime) {
                            _hasDate = true;
                            _selectedDateTime = dateTime;
                            String t = Jiffy(dateTime).format("HH:mm");
                            print("selected time: $t");
                            onSelectedValue!(
                              Answer.fill(question!.id, question!.fieldSet, t, null, t, transtypeResourceType(question!.resourcetype!), answerHolder!.id, null),
                            );
                            state.didChange(_selectedDateTime);
                            setState(() {});
                          },
                        ),
                      ),
                      state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
                    ],
                  );
                },
                validator: (value) {
                  if (isRequired(question)) if (_selectedDateTime == null) return FORM_SELECT_TIME;
                  return null;
                },
              ),
            if (widget.viewOnly) fieldData(Jiffy(_currentDateTime).format("HH:mm")),
            Divider(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
