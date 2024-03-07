import 'package:badges/badges.dart' as badges;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FCMNotificationsDao.dart';
import 'package:rightnow/models/fcm_notification.dart';

class FCMCounterWidget extends StatefulWidget {
  const FCMCounterWidget({Key? key}) : super(key: key);

  @override
  _FCMCounterWidgetState createState() => _FCMCounterWidgetState();
}

class _FCMCounterWidgetState extends State<FCMCounterWidget> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // Getting the token makes everything work as expected
    _firebaseMessaging.getToken().then((String? token) {
      print("token is $token");
      assert(token != null);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      setState(() {});
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /*return Container(
      child: ValueListenableBuilder(
        valueListenable: Hive.box<FCMNotification>('FCMNotification').listenable(),
        builder: (context, value, child) {},
      ),
    );*/
    return Container(
      child: FutureBuilder<List<FCMNotification>>(
        future: getDataBase<FCMNotificationsDao>().fetchFCMNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return badges.Badge(
              badgeContent: Text(
                (snapshot.data?.length ?? 0).toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Icon(
                Icons.notifications_outlined,
                size: 30,
                color: COLOR_PRIMARY,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
