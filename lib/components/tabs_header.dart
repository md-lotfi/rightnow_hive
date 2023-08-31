import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/models/form_state.dart';

class TabItemHolder {
  final String title;
  final int id;

  TabItemHolder(this.title, this.id);
}

class TabsHeaderWidget extends StatefulWidget {
  final Function(int selectedId) onSelected;
  const TabsHeaderWidget({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  _TabsHeaderWidgetState createState() => _TabsHeaderWidgetState();
}

class _TabsHeaderWidgetState extends State<TabsHeaderWidget> {
  int _selectionDisplay = -1;

  //TabItemHolder? _tabItemHolder;

  Widget _formatTab(String title, selectionDisplay) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectionDisplay = selectionDisplay;
        });
        widget.onSelected(_selectionDisplay);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
        decoration: BoxDecoration(
          color: _selectionDisplay == selectionDisplay ? COLOR_PRIMARY : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(color: _selectionDisplay == selectionDisplay ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  /*List<TabItemHolder> _elements = [];

  @override
  void initState() {
    _elements = [
      TabItemHolder("Tous".tr(), -1),
      TabItemHolder("Envoyé".tr(), -2),
      TabItemHolder("Non-envoyé".tr(), -3),
    ];
    _tabItemHolder = _elements[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FormFieldsState>>(
      future: getDataBase<FormStateDao>().fetchFormStates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            for (var i = 0; i < snapshot.data!.length; i++) {
              _elements.add(TabItemHolder(snapshot.data![i].getName(context.locale.languageCode), snapshot.data![i].id!));
            }
          }
          return Container(
            width: double.infinity,
            height: 40,
            child: DropdownButton<TabItemHolder>(
              value: _tabItemHolder,
              //icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              //style: const TextStyle(color: Colors.deepPurple),
              underline: SizedBox(),
              /*Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),*/
              onChanged: (TabItemHolder? value) {
                // This is called when the user selects an item.
                setState(() {
                  _tabItemHolder = value!;
                });
                log("selected value ${value?.id}");
                widget.onSelected(value!.id);
              },
              items: _elements.map<DropdownMenuItem<TabItemHolder>>((TabItemHolder value) {
                return DropdownMenuItem<TabItemHolder>(
                  value: value,
                  child: Text(value.title),
                );
              }).toList(),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = [
      _formatTab("Tous".tr(), -1),
      _formatTab("Envoyé".tr(), -2),
      _formatTab("Non-envoyé".tr(), -3),
    ];
    return FutureBuilder<List<FormFieldsState>>(
      future: getDataBase<FormStateDao>().fetchFormStates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            for (var i = 0; i < snapshot.data!.length; i++) {
              elements.add(
                _formatTab(snapshot.data![i].getName(context.locale.languageCode), snapshot.data![i].id),
              );
            }
          }
          return Container(
            width: double.infinity,
            height: 40,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Container(
                  width: 10,
                );
              },
              itemCount: elements.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return elements[index];
              },
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
