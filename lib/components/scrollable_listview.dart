import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollableListView extends StatelessWidget {
  final List<Widget> children;
  ScrollController _listScrollCrontroller = ScrollController();

  ScrollableListView({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
        scrollbars: false,
      ),
      child: Scrollbar(
        trackVisibility: true,
        controller: _listScrollCrontroller,
        child: ListView(
          controller: _listScrollCrontroller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: children,
        ),
      ),
    );
  }
}
