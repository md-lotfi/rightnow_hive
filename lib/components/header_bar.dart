import 'package:flutter/material.dart';
import 'package:rightnow/constants/constants.dart';

class HeaderBarWidget extends StatelessWidget {
  Widget Function(BuildContext context) builder;
  final double? height;
  HeaderBarWidget({
    Key? key,
    required this.builder,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: builder(context),
      ),
    );
  }
}
