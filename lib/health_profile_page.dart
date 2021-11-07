import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/health_profile_widget.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';

class HealthProfilePage extends StatefulWidget {
  const HealthProfilePage({Key? key}) : super(key: key);

  @override
  _HealthProfilePageState createState() => _HealthProfilePageState();
}

class _HealthProfilePageState extends State<HealthProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: WillPopScope(
      child: Scaffold(
        body: Column(
          children: [
            HeaderBarWidget(builder: (context) {
              return Container(
                margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 40),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/axa-logo.png",
                      fit: BoxFit.contain,
                      width: 70,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Etat de santé".tr(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: COLOR_PRIMARY,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Répondre aux questions pour compléter votre inscription".tr(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: COLOR_PRIMARY,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: _body(context),
            )),
          ],
        ),
      ),
      onWillPop: () async {
        SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HealthProfilePage(),
            ),
          );
        });
        return true;
      },
    ));
  }

  Widget _body(BuildContext context) {
    return HealthProfileWidget(
      onResult: (health) async {
        ApiRepository api = ApiRepository();
        showLoaderDialog(context);
        bool res = await api.setUserHealth(health);
        Navigator.pop(context);
        if (res) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          Alert(
            context: context,
            type: AlertType.error,
            title: "Erreur!".tr(),
            desc: "Server error".tr(),
            buttons: [
              DialogButton(
                child: Text(
                  "Ok".tr(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Navigator.pop(context),
                width: 120,
              )
            ],
          ).show();
        }
      },
    );
  }
}
