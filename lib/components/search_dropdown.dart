import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:collection/collection.dart';
import 'package:rightnow/components/tile_checkbox_widget.dart';
import 'package:rightnow/constants/constants.dart';

class SearchableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final String dialogTitle;
  final String Function(int index, T data) itemBuilder;
  final List<T> Function(List<T> items, String search) searchBuilder;
  final Function(List<T> selectedValue) onSelected;
  final List<T>? defaultValues;
  final Widget Function() builder;
  const SearchableDropdown({
    Key? key,
    required this.items,
    required this.dialogTitle,
    required this.itemBuilder,
    required this.searchBuilder,
    required this.onSelected,
    required this.builder,
    this.defaultValues,
  }) : super(key: key);

  @override
  _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  ValueNotifier<List<T>> _searchValues = ValueNotifier([]);
  TextEditingController _textSearch = TextEditingController();

  List<T> _selectedChoices = [];

  @override
  void initState() {
    super.initState();

    if (widget.defaultValues != null) {
      _selectedChoices = widget.defaultValues?.toList() ?? [];
    }
  }

  _showList() {
    Alert(
        context: context,
        title: widget.dialogTitle,
        content: Column(
          children: [
            TextField(
              controller: _textSearch,
              decoration: InputDecoration(
                icon: Icon(Icons.list),
                labelText: 'Search'.tr(),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchValues.value = widget.searchBuilder(widget.items, _textSearch.text);
                  },
                  child: Icon(Icons.search),
                ),
              ),
              onChanged: (value) {
                _searchValues.value = widget.searchBuilder(widget.items, value);
              },
            ),
            Divider(),
            Container(
              width: 400,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ValueListenableBuilder<List<T>>(
                valueListenable: _searchValues,
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: _searchValues.value.length,
                    itemBuilder: (context, index) {
                      T d = _searchValues.value[index];
                      var _selected = _selectedChoices.firstWhereOrNull(
                            (element) => element == d,
                          ) !=
                          null;
                      return TileCheckBoxWidget(
                        defaultSelected: _selected,
                        onChange: (value) {
                          print("selected now");
                          if (value) {
                            if (_selectedChoices.firstWhereOrNull(
                                  (element) => element == d,
                                ) ==
                                null) {
                              _selectedChoices.add(d);
                              return;
                            }
                          }
                          print("removing $d");
                          _selectedChoices.removeWhere((element) => element == d);
                          print("removed now $_selectedChoices");
                          /*setState(() {
                            print("setting choice ${_searchValues.value[index]}");
                            //_selectedChoices.add(_searchValues.value[index]);
                          });*/
                        },
                        title: widget.itemBuilder(index, _searchValues.value[index]),
                      );
                      /*return InkWell(
                        onTap: () {
                          _selectedChoices.add(_searchValues.value[index]);
                          //widget.onSelected(_searchValues.value[index]);
                          //Navigator.pop(context);
                        },
                        child: widget.itemBuilder(index, _searchValues.value[index]),
                      );*/
                      //return Container();
                    },
                  );
                },
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: COLOR_PRIMARY,
            onPressed: () {
              print("selected choices $_selectedChoices");
              widget.onSelected(_selectedChoices);

              Navigator.pop(context);
            },
            child: Text(
              "Ok".tr(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    _searchValues.value = widget.items;
    //this._showList()
    //_showList();
    //return widget.builder(this);
    return InkWell(
      onTap: () {
        _showList();
      },
      child: widget.builder(),
    );
  }
}
