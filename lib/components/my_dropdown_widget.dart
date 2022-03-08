import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:rightnow/main.dart';

class MyDropDownWidget<T> extends StatefulWidget {
  final String label;
  final List<PopupMenuItem<T>> choicesDropdownList;
  const MyDropDownWidget({
    Key? key,
    required this.choicesDropdownList,
    required this.label,
  }) : super(key: key);

  @override
  _MyDropDownWidgetState createState() => _MyDropDownWidgetState<T>();
}

class _MyDropDownWidgetState<T> extends State<MyDropDownWidget> {
  Color _color = Colors.white;

  OverlayState? overlayState;
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      child: PopupMenuButton(
        //offset: const Offset(0, -380),
        itemBuilder: (context) {
          return widget.choicesDropdownList;
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            //Icon(Icons.more_vert, color: Colors.white60),
            //Text("more", style: Theme.of(context).textTheme.caption),
            Expanded(flex: 8, child: Text(widget.label)),
            Expanded(
              flex: 2,
              child: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }
}

class PopUpMenuTile extends StatelessWidget {
  const PopUpMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.showDivider,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final bool isActive;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /*Icon(icon, color: isActive ? Colors.red : Colors.grey),
        const SizedBox(
          width: 8,
        ),*/
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        ),
        if (this.showDivider) Divider(),
        /*Container(
          height: 1,
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Text("frfr"),
        ),*/
      ],
    );
  }
}
