import 'package:flutter/material.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class LienUtilesDetails extends StatelessWidget {
  const LienUtilesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("Couverture santé".tr()),
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      backgroundColor: Colors.white,
      body: Container(
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: COLOR_PRIMARY,
          child: ScrollTouchWidget(
              listChild: ListView(
            children: [
              _image("0001.jpg"),
              Divider(),
              _image("0002.jpg"),
              Divider(),
              _image("0003.jpg"),
              Divider(),
              _image("0004.jpg"),
              Divider(),
              _image("0005.jpg"),
            ],
          )),
        ),
      ),
    ));
  }

  Widget _image(String path) {
    return Container(
      child: Image.asset("assets/$path"),
    );
  }
}
