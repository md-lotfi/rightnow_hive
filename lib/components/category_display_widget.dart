import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';

import 'package:rightnow/constants/constants.dart';

class CategoryDisplayWidget extends StatelessWidget {
  final String title;
  final String? icon;
  final Function() onTap;
  const CategoryDisplayWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("loading image of $icon");
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        color: COLOR_PRIMARY,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          onTap();
        },
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        //trailing: icon != null ? Image.network(icon!) : null,
        trailing: loadImage(icon),
      ),
    );
  }
}
