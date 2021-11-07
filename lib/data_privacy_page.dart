import 'package:flutter/material.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/header_bar.dart';
import 'package:rightnow/connexion_type.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/login_page.dart';
import 'package:rightnow/screen_viewer.dart';

class DataPrivacyPage extends StatefulWidget {
  const DataPrivacyPage({Key? key}) : super(key: key);

  @override
  _DataPrivacyPageState createState() => _DataPrivacyPageState();
}

class _DataPrivacyPageState extends State<DataPrivacyPage> {
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
                      child: Text(
                        "Confidentialité des données".tr(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: COLOR_PRIMARY,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 70,
                    child: _body(),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                      child: TextButton(
                          onPressed: () {
                            redirectUser(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HashPage(),
                                ),
                              );
                            }, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConnexionTypeScreen(),
                                ),
                              );
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );*/
                            });
                          },
                          child: Text("Continuer".tr())),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      onWillPop: () async {
        return true;
      },
    ));
  }

  Widget _body() {
    return ListView(
      children: [
        ListTile(
            leading: Icon(
              Icons.check_circle_outlined,
              color: Colors.green,
              size: 40,
            ),
            title: Text("Vos données sont sécurisées à l'aide d'un système de chiffrement.".tr())),
        ListTile(
            leading: Icon(
              Icons.check_circle_outlined,
              color: Colors.green,
              size: 40,
            ),
            title: Text("Votre identité est anonymes.".tr())),
        ListTile(
            leading: Icon(
              Icons.check_circle_outlined,
              color: Colors.green,
              size: 40,
            ),
            title: Text("Vos données sont hébergées dans des serveurs en Algérie.".tr())),
        ListTile(
            leading: Icon(
              Icons.check_circle_outlined,
              color: Colors.green,
              size: 40,
            ),
            title: Text("Aucune utilisation de vos informations ne sera faite sans votre accord.".tr())),
      ],
    );
  }
}
