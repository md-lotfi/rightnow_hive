import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollWidget extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final bool? shrinkWrap;
  final ScrollController? defaultScrollController;
  ScrollWidget({
    Key? key,
    required this.children,
    this.padding,
    this.shrinkWrap,
    this.defaultScrollController,
  }) : super(key: key);

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      child: ListView(
        padding: padding,
        controller: defaultScrollController != null ? defaultScrollController : _controller,
        //mainAxisAlignment: MainAxisAlignment.center,
        shrinkWrap: shrinkWrap ?? false,
        children: children,
      ),
    );
  }
}
