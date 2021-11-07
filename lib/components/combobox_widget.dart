import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';

class ComboField<T> extends StatefulWidget {
  final String? title;
  final List<T>? values;
  final T? resultValue;
  final Function(T)? onResult;
  final bool? showLabel;
  final Color? backgroundColor;
  final List<String>? displayValues;
  final Widget Function(dynamic value)? valueBuilder;
  const ComboField({Key? key, this.title, this.values, this.valueBuilder, this.resultValue, this.onResult, this.showLabel, this.backgroundColor, this.displayValues}) : super(key: key);
  @override
  _ComboFieldState createState() => _ComboFieldState<T>(title, values, resultValue, onResult, showLabel, backgroundColor);
}

class _ComboFieldState<T> extends State<ComboField> {
  final String? title;
  final List<T>? values;
  T? resultValue;
  final Function(T)? onResult;
  final bool? showLabel;
  final Color? backgroundColor;

  _ComboFieldState(this.title, this.values, this.resultValue, this.onResult, this.showLabel, this.backgroundColor);

  @override
  void initState() {
    //if (onResult != null && mounted) onResult!(resultValue!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("title is $title");
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 49,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(style: BorderStyle.solid, width: 0.80, color: Colors.grey.shade300),
            color: backgroundColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: resultValue,
              dropdownColor: Colors.white,
              onChanged: (T? newValue) {
                if (onResult != null) {
                  onResult!(newValue!);
                  setState(() {
                    resultValue = newValue;
                  });
                }
              },
              items: values!.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: widget.valueBuilder == null ? _valueToText(value) : widget.valueBuilder!(value),

                  ///Text(value as String),
                  //child: Text(value == 0 ? 'Undefined'.tr() : (value == 1 ? 'Male'.tr() : 'Female'.tr())),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _valueToText(dynamic value) {
    if (value is int && widget.displayValues != null) {
      return Text(widget.displayValues![value]);
    } else if (value is String) {
      return Text(value);
    }
    return Text(value.toString());
  }
}
