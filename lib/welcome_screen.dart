import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/language_widget.dart';
import 'package:rightnow/preventive1.dart';
import 'package:rightnow/user_consent_screen.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Jiffy.locale(context.locale.languageCode);
    });
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.all(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image(
              image: AssetImage("assets/welcome.png"),
              fit: BoxFit.cover,
            ),
            Positioned(
              top: MediaQuery.of(context).size.width > 800 ? 20 : 60,
              left: MediaQuery.of(context).size.width > 800 ? 20 : 30,
              right: MediaQuery.of(context).size.width > 800 ? 20 : 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Image.asset(
                      "assets/axxa_logo_transparent.png",
                      width: 70,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(8),
                    child: LanguageWidget(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.width > 800 ? 20 : 30,
              left: MediaQuery.of(context).size.width > 800 ? 20 : 30,
              right: MediaQuery.of(context).size.width > 800 ? 20 : 30,
              child: Column(
                children: [
                  Text(
                    "Industrial grade mobile data collection".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 24),
                        shadows: [
                          /*Shadow(
                            //offset: Offset(10.0, 10.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),*/
                          Shadow(
                            //offset: Offset(10.0, 10.0),
                            blurRadius: 2.0,
                            color: Colors.black,
                          ),
                        ],
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "retrieve accurate data, flag critical issues, reduce data entry errors, validate answers, offer secured and encrypted information and smart algorithm".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 12), fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                  SizedBox(
                    height: AdaptiveTextSize().getadaptiveTextSize(context, 25),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        redirectUser(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Preventive1(),
                            ),
                          );
                        }, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserConsentScreen(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        "Commencez".tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AdaptiveTextSize().getadaptiveTextSize(context, 10)),
                  /*Container(
                    child: Text(
                      'En vous cliquant sur "Commencez" vous acceptez'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10), fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: AdaptiveTextSize().getadaptiveTextSize(context, 5)),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CguScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "les conditions générales d'utilisation".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 10), fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
