import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/models/about.dart';
import 'package:rightnow/models/social_links.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  ApiRepository api = ApiRepository();
  Widget _title(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 13),
        fontFamily: "PoppinsMedium",
        color: Color(0xFF00008F),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _content(BuildContext context, String content) {
    return ListTile(
      title: Html(
        data: content,
        style: {
          "p": Style(
            fontFamily: "PoppinsMedium",
            textAlign: TextAlign.justify,
          ),
        },
        onLinkTap: (url, _, __, ___) async {
          print("Opening $url...");
          bool b = await canLaunch(url ?? "");
          if (b) launch(url ?? "");
        },
      ),
      /*Text(
        content,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 13),
          fontFamily: "PoppinsRegular",
          color: Color(0xFF707070),
        ),
      ),*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      bottomNavigationBar: HomeNavBarComp(
        NavState.NAV_FORMS_INDEX,
      ),
      appBar: AppBar(
        //backgroundColor: Colors.grey.shade50,
        title: Text('A propos'.tr()),
        //leading: Icon(MdiIcons.bell),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<bool>(
        future: api.hasInternetConnection(),
        builder: (context, s) {
          if (s.connectionState == ConnectionState.done) {
            if (s.data == true) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 140,
                    child: RawScrollbar(
                      isAlwaysShown: true,
                      thumbColor: COLOR_PRIMARY,
                      child: _body(context),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Container(
                      height: 120,
                      child: getContactWidgets(),
                    ),
                  ),
                ],
              );
            }
            return _bodyNoInternet(context);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }

  Widget _bodyNoInternet(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Text(
            "Ce rubrique n’est pas disponible en mode hors ligne, Veuillez vous connectez  à internet pour avoir plus d’informations.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15)),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.refresh,
            color: COLOR_PRIMARY,
            size: 25,
          ),
        ),
      ],
    ));
  }

  Widget _bodyElem(BuildContext context, About about) {
    return Card(
      child: ExpansionTile(
        collapsedTextColor: Colors.black,
        textColor: Colors.black,
        collapsedIconColor: Colors.black,
        iconColor: Colors.black,
        title: _title(context, about.getTitle(context.locale.languageCode)),
        //trailing: Icon(Icons.chevron_right),
        children: [
          _content(
            context,
            about.getDescription(context.locale.languageCode),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 20, left: 25, right: 25),
      child: FutureBuilder<List<About>>(
        future: api.getAbout(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              List<Widget> w = [];
              for (var item in snapshot.data ?? []) {
                w.add(_bodyElem(context, item));
              }
              return ScrollTouchWidget(
                  listChild: ListView(
                shrinkWrap: true,
                children: w,
              ));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getContactWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 3,
          child: SizedBox(
            width: 300,
            child: FutureBuilder<List<SocialLinks>>(
              future: api.getSocialLinks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != null) {
                    List<Widget> w = [];
                    for (var item in snapshot.data ?? []) {
                      w.add(InkWell(
                        onTap: () async {
                          bool x = await canLaunch(item.link ?? "");
                          if (x) await launch(item.link ?? "");
                        },
                        child: Image.network(
                          //image: AssetImage('assets/facebook.png'),
                          item.icon ?? "",
                          width: 50,
                          fit: BoxFit.scaleDown,
                        ),
                      ));
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: w,
                    );
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: SizedBox(
            width: 300,
            //height: 100,
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 15, right: 15),
              child: Text(
                "Suivez-nous sur".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
