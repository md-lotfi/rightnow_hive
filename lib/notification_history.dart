import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rightnow/components/bottom_nav_home.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FCMNotificationsDao.dart';
import 'package:rightnow/models/user_notification.dart';
import 'package:rightnow/notification_detail.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/screen_viewer.dart';

class NotificationHistoryPage extends StatefulWidget {
  NotificationHistoryPage({Key? key}) : super(key: key);

  @override
  _NotificationHistoryPageState createState() => _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  ApiRepository api = ApiRepository();

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getDataBase<FCMNotificationsDao>().removeAllFCMNotification();
    });
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text("Notifications".tr()),
        centerTitle: true,
        elevation: 1,
      ),
      bottomNavigationBar: HomeNavBarComp(NavState.NAV_HOME_INDEX),
      backgroundColor: Colors.white,
      body: Container(
        child: FutureBuilder<List<UserNotification>>(
          future: api.notificationHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Center(
                  child: RawScrollbar(
                      isAlwaysShown: true,
                      thumbColor: COLOR_PRIMARY,
                      child: RefreshIndicator(
                        child: Container(
                          //color: Colors.red,
                          child: _notificationBuilder(snapshot.data ?? []),
                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        ),
                        onRefresh: () async {
                          setState(() {});
                          return await Future.delayed(
                            Duration(seconds: 3),
                          );
                        },
                      )),
                );
                //return _notificationBuilder(snapshot.data!);
              }
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    ));
  }

  Widget _notificationBuilder(List<UserNotification> data) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _item(data[index]),
          ],
        );
      },
    );
  }

  Widget _item(UserNotification data) {
    log("viewed state ${data.viewed}");
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: data.viewed == 0 ? Colors.grey.shade400 : null,
      ),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 17, right: 17),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetail(
              notification: data,
            ),
          ),
        ).then((value) => setState(() {})),
        title: Text(data.getTitle(context.locale.languageCode), style: TextStyle(fontWeight: FontWeight.bold)),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Jiffy(data.createdAt).yMMMd, textAlign: TextAlign.center),
            Text(
              Jiffy(data.createdAt).Hm,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 12),
          child: Text(
            "Par Rightnow".tr(),
            style: TextStyle(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}
