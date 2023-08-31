/*import 'package:flutter/material.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/data_privacy_page.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/views/language_switch.dart';

class Preventive1 extends StatelessWidget {
  const Preventive1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Stack(
      children: [
        Positioned.fill(
          child: FittedBox(
            child: context.locale.languageCode == LANGUAGE_FR
                ? Image.asset(
                    "assets/prevention1.png",
                  )
                : Image.asset(
                    "assets/prevention1AR.png",
                  ),
            fit: BoxFit.fill,
          ),
        ),
        /*Positioned(
          top: 60,
          left: 30,
          child: Icon(
            Icons.close,
            color: COLOR_PRIMARY,
          ),
        ),*/
        Positioned(
          bottom: 20,
          right: 30,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              primary: COLOR_PRIMARY,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataPrivacyPage(),
                ),
              );
            },
            child: Text(
              "Suivant".tr(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ));
  }
}
*/