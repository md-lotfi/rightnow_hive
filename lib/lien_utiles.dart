import 'package:flutter/material.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/lien_utiles_details.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class LienUtiles extends StatelessWidget {
  const LienUtiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("Lien Utiles".tr()),
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: COLOR_PRIMARY,
          child: ScrollTouchWidget(
            listChild: ListView(
              children: [
                ListTile(
                  onTap: () async {
                    bool c = await canLaunch("https://www.brenco-algerie.com");
                    if (c) launch("https://www.brenco-algerie.com");
                  },
                  leading: Image.asset("assets/brenco.png"),
                  subtitle: Text("www.brenco-algerie.com", style: TextStyle(color: Colors.blue)),
                  title: Text(
                    "Site Web BRENCO E&C".tr(),
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  trailing: Icon(Icons.link_outlined),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    bool c = await canLaunch("https://www.rightnow-by-brenco.com");
                    if (c) launch("https://www.rightnow-by-brenco.com");
                  },
                  leading: Image.asset("assets/axa-logo.png"),
                  subtitle: Text("www.rightnow-by-brenco.com", style: TextStyle(color: Colors.blue)),
                  title: Text(
                    "Site Web RIGHTNOW".tr(),
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                  trailing: Icon(Icons.link_outlined),
                ),
                /*ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LienUtilesDetails(),
                    ),
                  );
                },
                leading: Image.asset("assets/utils_doc.png"),
                title: Text(
                  "Couverture santé collaborateur".tr(),
                  //style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
                trailing: Icon(Icons.image_outlined),
              ),
              Divider(),
              ListTile(
                onTap: () async {
                  bool c = await canLaunch("https://www.linkedin.com/company/axa/");
                  if (c) launch("https://www.linkedin.com/company/axa/");
                },
                leading: Image.asset("assets/utils_linkedin.png"),
                title: Text(
                  "LINKEDIN Learning".tr(),
                  //style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
                trailing: Icon(Icons.link),
              ),*/
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
