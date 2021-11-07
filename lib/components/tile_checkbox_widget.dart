import 'package:flutter/material.dart';

import 'package:rightnow/models/disease.dart';

class TileCheckBoxWidget extends StatefulWidget {
  final bool defaultSelected;
  final String title;
  final Function(bool value) onChange;
  const TileCheckBoxWidget({
    Key? key,
    required this.defaultSelected,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  @override
  _TileCheckBoxWidgetState createState() => _TileCheckBoxWidgetState();
}

class _TileCheckBoxWidgetState extends State<TileCheckBoxWidget> {
  bool _selected = false;

  @override
  void initState() {
    _selected = widget.defaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      selectedTileColor: Colors.grey.shade200,
      //selected: _index.contains(d.id),
      selected: _selected,
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      value: _selected,
      dense: true,
      contentPadding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          _selected = value;
          widget.onChange(value);
        });
      },
    );
  }
}
