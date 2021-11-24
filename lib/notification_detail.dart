import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rightnow/components/adaptative_text_size.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/UserNotificationsDao.dart';
import 'package:rightnow/models/user_notification.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDetail extends StatelessWidget {
  final UserNotification notification;
  const NotificationDetail({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getDataBase<UserNotificationsDao>().setUserNotificationViewed(notification.id!);
    });
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("Détails".tr()),
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            ListTile(
              title: Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  notification.getTitle(context.locale.languageCode),
                  style: TextStyle(fontSize: AdaptiveTextSize().getadaptiveTextSize(context, 15), fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              title: Container(
                //margin: EdgeInsets.only(bottom: 25),
                child: Html(
                  data: notification.getContent(context.locale.languageCode),
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
                //Text(notification.getContent(context.locale.languageCode)),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
