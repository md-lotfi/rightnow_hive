import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class InlineDate extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final DateTime? currentDate;

  const InlineDate({Key? key, this.onDateSelected, this.currentDate}) : super(key: key);

  @override
  _InlineDateState createState() => _InlineDateState(onDateSelected, currentDate);
}

class _InlineDateState extends State<InlineDate> {
  final Function(DateTime)? onDateSelected;
  final DateTime? currentDate;
  int curDay = DateTime.now().day;
  int curMonth = DateTime.now().month;
  int curYear = DateTime.now().year;

  _InlineDateState(this.onDateSelected, this.currentDate);

  @override
  Widget build(BuildContext context) {
    return getDateWidget();
  }

  @override
  void initState() {
    if (currentDate != null) {
      curDay = currentDate!.day;
      curMonth = currentDate!.month;
      curYear = currentDate!.year;
    }
    super.initState();
  }

  /*int daysInMonth(int year, int month) {
    DateTime x1 = DateTime(year, month, 0).toUtc();
    return DateTime(year, month, 0).toUtc().difference(x1).inDays;
  }*/

  List<DropdownMenuItem<int>> _daysFill() {
    //var dateUtility = DateUtil();
    var d = DateUtils.getDaysInMonth(curYear, curMonth);
    List<DropdownMenuItem<int>> list = [];
    print('days in a month $curYear $curMonth $d');
    for (var i = 1; i <= d; i++) {
      list.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString().padLeft(2, "0")),
        ),
      );
    }
    /*setState(() {
      curDay = DateTime.now().day;
    });*/
    return list;
  }

  List<DropdownMenuItem<int>> _monthFill() {
    List<DropdownMenuItem<int>> list = [];
    for (var i = 1; i <= 12; i++) {
      list.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString().padLeft(2, "0")),
        ),
      );
    }
    return list;
  }

  List<DropdownMenuItem<int>> _yearFill() {
    List<DropdownMenuItem<int>> list = [];
    for (var i = 1950; i <= DateTime.now().year; i++) {
      list.add(
        DropdownMenuItem(
          value: i,
          child: Text(i.toString()),
        ),
      );
    }
    return list;
  }

  /*TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Jour",
              labelText: "Jour",
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ), */

  Widget getDateWidget() {
    return Row(
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<int>(
              hint: Text("Jour".tr()),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
              isExpanded: true,
              value: curDay,
              items: _daysFill(),
              onChanged: (value) {
                setState(() {
                  curDay = value!;
                  onDateSelected!(DateTime(curYear, curMonth, curDay));
                });
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<int>(
              hint: Text("Mois".tr()),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
              isExpanded: true,
              value: curMonth,
              items: _monthFill(),
              onChanged: (value) {
                setState(() {
                  curMonth = value!;
                  onDateSelected!(DateTime(curYear, curMonth, curDay));
                });
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(style: BorderStyle.solid, width: 0.80),
            ),
            child: DropdownButton<int>(
              hint: Text("Année".tr()),
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
              isExpanded: true,
              value: curYear,
              items: _yearFill(),
              onChanged: (value) {
                setState(() {
                  curYear = value!;
                  onDateSelected!(DateTime(curYear, curMonth, curDay));
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
