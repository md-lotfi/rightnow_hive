import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

const String MALE = "Homme";
const String FEMALE = "Femme";

class GenreWidget extends StatefulWidget {
  final Function(String?) onSelectGender;
  final String defaultGender;

  const GenreWidget({Key? key, required this.onSelectGender, required this.defaultGender}) : super(key: key);

  @override
  _GenreWidgetState createState() => _GenreWidgetState();
}

class _GenreWidgetState extends State<GenreWidget> {
  String? _currentChoice;
  List<DropdownMenuItem<String>>? _choicesDropdownList;

  @override
  void initState() {
    print("gender is " + widget.defaultGender);
    _choicesDropdownList = _dropdownItems();

    if (widget.defaultGender != null) {
      _currentChoice = widget.defaultGender;
    } else {
      if (_choicesDropdownList!.length > 0) _currentChoice = _choicesDropdownList![0].value;
    }
    /*setState(() {
      _currentChoice = _dropdownItems();
    });*/
    super.initState();
  }

  List<DropdownMenuItem<String>> _dropdownItems() {
    List<DropdownMenuItem<String>> l = [];
    l.add(DropdownMenuItem(
      value: MALE,
      child: Text(MALE.tr()),
    ));
    l.add(DropdownMenuItem(
      value: FEMALE,
      child: Text(FEMALE.tr()),
    ));
    return l;
  }

  void changedDropDownItem(String? choice) {
    setState(() {
      _currentChoice = choice;
      widget.onSelectGender(_currentChoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5, top: 10, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(style: BorderStyle.solid, width: 0.80),
      ),
      child: DropdownButton(
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 42,
        underline: SizedBox(),
        isExpanded: true,
        value: _currentChoice,
        items: _choicesDropdownList,
        onChanged: changedDropDownItem,
      ),
    );
  }
}
