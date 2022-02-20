import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScreenViewerWidget extends StatelessWidget {
  final Widget page;
  const ScreenViewerWidget({
    Key? key,
    required this.page,
  }) : super(key: key);

  Widget _home(BuildContext context) {
    if (!kIsWeb)
      return page;
    else {
      if (MediaQuery.of(context).size.width > 800) {
        return Stack(children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: MediaQuery.of(context).size.width / 2.8,
            child: FittedBox(
              child: Image.asset("assets/rightnow_splash.png"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 1.5,
            bottom: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                top: 30,
                bottom: 30,
                left: 60,
                right: 60,
              ),
              child: page,
            ),
          ),
        ]);
      } else {
        return page;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /*SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      print("width 2 is " + MediaQuery.of(context).size.width.toString());
    });*/
    //return _home(context);
    return Scaffold(
      body: _home(context),
    );
  }
}
