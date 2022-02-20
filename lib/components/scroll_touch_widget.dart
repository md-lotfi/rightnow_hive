import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScrollTouchWidget extends StatelessWidget {
  final Widget listChild;
  final EdgeInsetsGeometry? padding;
  final bool? shrinkWrap;
  final ScrollController? defaultScrollController;
  ScrollTouchWidget({
    Key? key,
    required this.listChild,
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
      child: listChild,
    );
  }
}
