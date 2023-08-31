import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/settings_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const RESSOURCE_VIDEO_ACTU = "VideoActu";
const RESSOURCE_ARTICLE_ACTU = "ArticleActu";
const RESSOURCE_LINK_ACTU = "LinkActu";

class ArticleDetailsPage extends StatelessWidget {
  final Actualite actualite;
  const ArticleDetailsPage({
    Key? key,
    required this.actualite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      //extendBodyBehindAppBar: true,
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME),
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
              icon: Icon(Icons.settings_outlined)),
        ],
      ),
      body: ScrollTouchWidget(
        listChild: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            //articleHeader(context, actualite),
            Image.network(
              actualite.thumbnail ?? "",
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/welcome.png', width: double.infinity, height: MediaQuery.of(context).size.height / 2, fit: BoxFit.fill);
              },
            ),
            articlaHeaderColumn(context, actualite),
            Container(
              padding: EdgeInsets.all(25),
              child: Html(
                data: actualite.getContent(context.locale.languageCode),
                style: {
                  "p": Style(
                    //color: Colors.black,
                    //fontSize: FontSize(15),
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
            )
          ],
        ),
      ),
    ));
  }
}
