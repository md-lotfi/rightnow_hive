import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/answer.dart';

class DateWidget extends StatefulWidget {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;
  final bool viewOnly;

  const DateWidget({
    Key? key,
    this.question,
    this.onSelectedValue,
    this.answerHolder,
    required this.viewOnly,
  }) : super(key: key);
  @override
  _DateWidgetState createState() => _DateWidgetState(this.question, this.answerHolder, this.onSelectedValue);
}

class _DateWidgetState extends State<DateWidget> with AutomaticKeepAliveClientMixin {
  final Question? question;
  final Function(Answer)? onSelectedValue;
  final AnswerHolder? answerHolder;

  _DateWidgetState(this.question, this.answerHolder, this.onSelectedValue);

  DateTime _currentDateTime = DateTime.now();
  DateTime? _selectedDateTime;

  bool _hasDate = false;

  @override
  void initState() {
    if (answerHolder != null) {
      if (answerHolder!.answers != null) {
        if (answerHolder!.answers!.length > 0) {
          for (var answer in answerHolder!.answers!) {
            if (answer.qustionId == question!.id) {
              if (isDate(answer.answerValue!)) {
                _hasDate = true;
                _currentDateTime = DateTime.parse(answer.answerValue!);
                _selectedDateTime = _currentDateTime;
              }
            }
          }
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return load();
  }

  Widget load() {
    DateTime? minDate = Jiffy(question?.minValue).dateTime;
    DateTime? maxDate = Jiffy(question?.maxValue).dateTime;
    if (question?.minValue == null) {
      minDate = null;
    }
    if (question?.maxValue == null) {
      maxDate = null;
    }
    print(context.locale.countryCode);
    //context.setLocale(Locale('ar', 'DZ'));

    return Padding(
      padding: EdgeInsets.only(top: 10, left: 15, bottom: 10, right: 15),
      child: Container(
        child: FormField<DateTime>(
          autovalidateMode: AutovalidateMode.always,
          initialValue: _selectedDateTime,
          builder: (FormFieldState<DateTime> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widgetQuestionTitle(question!, context.locale.languageCode),
                if (!widget.viewOnly)
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: (!_hasDate
                        ? BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      minimumDate: minDate,
                      maximumDate: maxDate,
                      initialDateTime: _currentDateTime,
                      onDateTimeChanged: (DateTime dateTime) {
                        print("dateTime: " + Jiffy(dateTime).format("yyyy-MM-dd"));
                        _hasDate = true;
                        _selectedDateTime = dateTime;
                        onSelectedValue!(
                          Answer.fill(question!.id, question!.fieldSet, Jiffy(dateTime).format("yyyy-MM-dd"), null, DateTime.now().toString(), transtypeResourceType(question!.resourcetype!),
                              answerHolder!.id, null),
                        );
                        state.didChange(_selectedDateTime);
                        setState(() {});
                      },
                    ),
                  ),
                if (widget.viewOnly) fieldData(Jiffy(_currentDateTime).format("dd/MM/yyyy")),
                Divider(),
                state.errorText == null ? Text("") : Text(state.errorText ?? "", style: TextStyle(color: Colors.red)),
              ],
            );
          },
          validator: (value) {
            if (isRequired(question)) if (_selectedDateTime == null) return FORM_SELECT_DATE;
            return null;
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
