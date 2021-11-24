import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:rightnow/models/user_notification.dart';

class UserNotificationsDao {
  Future<Box<UserNotification>> getUserNotificationDb() async {
    return await Hive.openBox<UserNotification>('UserNotification');
  }

  Future<UserNotification?> getUserNotification(int notifId) async {
    var r = await getUserNotificationDb();
    for (var item in r.values) {
      return item;
    }
    return null;
  }

  Future<UserNotification?> removeAllUserNotification() async {
    var r = await getUserNotificationDb();
    log("deleting all user notifications, found ${r.values.length}");
    for (var item in r.values) {
      await item.delete();
    }
  }

  Future<List<UserNotification>> fetchUserNotification() async {
    var r = await getUserNotificationDb();
    return r.values.toList();
  }

  Future<void> setUserNotificationViewed(int notifId) async {
    var r = await getUserNotificationDb();
    for (var item in r.values) {
      if (notifId == item.id) {
        item.viewed = 1;
        item.save();
      }
    }
  }

  Future<void> insertUserNotificationsIfNotPresent(List<UserNotification> userNotifications) async {
    var r = await getUserNotificationDb();
    List<int?> ids = r.values.map((e) => e.id).toList();
    for (var item in userNotifications) {
      if (ids.length > 0) {
        if (!ids.contains(item.id)) {
          item.viewed = 0;
          log("saving user notification $item");
          await r.add(item);
        }
      } else {
        item.viewed = 0;
        log("saving user notification $item");
        await r.add(item);
      }
    }
    /*if (ids.length > 0) {
      for (var item in userNotifications) {
        if (!ids.contains(item.id)) {
          item.viewed = 0;
          log("saving user notification $item");
          await r.add(item);
        }
      }
    } else
      await r.addAll(userNotifications);*/
  }
}
