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

class ChatPage extends StatelessWidget {
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
        onLinkTap: (url, attributes, element) async {
          print("Opening $url...");
          var uri = Uri.parse(url ?? "");
          bool b = await canLaunchUrl(uri);
          if (b) launchUrl(uri);
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
          NavState.NAV_CHAT,
        ),
        appBar: AppBar(
          //backgroundColor: Colors.grey.shade50,
          title: Text('Chat with us'.tr()),
          //leading: Icon(MdiIcons.bell),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Html(
                    /*customRender: {
                      "iframe": (RenderContext context, Widget child) {
                        final attrs = context.tree.element?.attributes;
                        double? width = 100;
                        double? height = 400;
                        return Container(
                          width: width,
                          height: height,
                          child: child,
                        );
                      }
                    },*/

                    data: """
<iframe src="https://tawk.to/startupdzsupport" height="550"></iframe>
""",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
