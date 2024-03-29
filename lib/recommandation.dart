import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/scroll_touch_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/rest/ApiClient.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommandationPage extends StatelessWidget {
  final DecisionResponse decision;
  const RecommandationPage({Key? key, required this.decision}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("AI Réponse".tr()), // Résultat
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        //margin:
        child: Scrollbar(
          trackVisibility: true,
          child: ScrollTouchWidget(
            listChild: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 80,
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: [
                      if (decision.imageActive == true) ...[
                        Container(
                          child: Image.network(
                            IMG_BASE_URL + (decision.image ?? ""),
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                      Container(
                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade100,
                        ),
                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                        child: Text(
                          decision.getTitle(context.locale.languageCode),
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 16)),
                        ),
                      ),
                      if (decision.textActive == true) ...[
                        Container(
                          child: Text(
                            "Résumé".tr(),
                            style: TextStyle(color: COLOR_PRIMARY, fontWeight: FontWeight.bold, fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 14)),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100,
                          ),
                          padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                          child: Html(
                            data: decision.getText(context.locale.languageCode),
                            style: {
                              "p": Style(
                                //color: Colors.black,
                                //fontSize: FontSize(15),
                                fontFamily: "PoppinsMedium",
                                textAlign: TextAlign.justify,
                              ),
                            },
                            onLinkTap: (url, attributes, element) async {
                              print("Opening $url...");
                              var uri = Uri.parse(url ?? "");
                              bool b = await canLaunchUrl(uri);
                              if (b) launchUrl(uri);
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                      if (decision.urlActive == true) ...[
                        InkWell(
                          onTap: () async {
                            bool ok = await canLaunch(decision.url ?? "");
                            if (ok) {
                              Navigator.pop(context);
                              launch(decision.url ?? "");
                            }
                          },
                          child: Container(
                            child: Text(
                              decision.url ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Text(
                            "Retour à l'acceuil".tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
