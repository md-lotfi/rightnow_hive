import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/lien_utiles_details.dart';
import 'package:rightnow/models/link.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class LienUtiles extends StatelessWidget {
  const LienUtiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiRepository api = ApiRepository();
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("Lien Utiles".tr()),
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: COLOR_PRIMARY,
          child: ScrollTouchWidget(
            listChild: FutureBuilder<List<Link>>(
              future: api.getLiensUtils(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _content(snapshot.data ?? []);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            /*listChild: ListView(
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
              ],
            ),*/
          ),
        ),
      ),
    ));
  }

  Widget _content(List<Link> links) {
    return ListView.builder(
      itemCount: links.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () async {
            if (links[index].linkUrl == null) return;
            bool c = await canLaunch(links[index].linkUrl!);
            if (c)
              launch(links[index].linkUrl!);
            else
              log("cannot launch ${links[index].linkUrl}");
          },
          leading: loadImage(links[index].icon, width: 70),
          //subtitle: Text("www.brenco-algerie.com", style: TextStyle(color: Colors.blue)),
          title: Text(
            links[index].getTitle(context.locale.languageCode),
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
          trailing: Icon(Icons.link_outlined),
        );
      },
    );
  }
}
