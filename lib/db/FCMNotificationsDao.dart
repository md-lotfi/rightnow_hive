import 'package:hive/hive.dart';
import 'package:rightnow/models/fcm_notification.dart';

class FCMNotificationsDao {
  Future<Box<FCMNotification>> getFCMNotificationDb() async {
    return await Hive.openBox<FCMNotification>('FCMNotification');
  }

  Future<FCMNotification?> getFCMNotification(int notifId) async {
    var r = await getFCMNotificationDb();
    for (var item in r.values) {
      return item;
    }
    return null;
  }

  Future<List<FCMNotification>> fetchFCMNotification() async {
    var r = await getFCMNotificationDb();
    return r.values.toList();
  }

  Future<void> removeAllFCMNotification() async {
    var r = await getFCMNotificationDb();
    for (var item in r.values) {
      await item.delete();
    }
  }

  Future<void> removeFCMNotification(int notifId) async {
    var r = await getFCMNotificationDb();
    for (var item in r.values) {
      if (item.id == notifId) await item.delete();
    }
  }

  Future<void> insertFCMNotifications(List<FCMNotification> fCMNotification) async {
    var r = await getFCMNotificationDb();
    await r.addAll(fCMNotification);
  }

  /*Future<void> insertFCMNotificationsIfNotPresent(List<FCMNotification> fCMNotification) async {
    var r = await getFCMNotificationDb();
    List<int?> ids = r.values.map((e) => e.id).toList();
    if (ids.length > 0) {
      for (var item in fCMNotification) {
        if (!ids.contains(item.id)) {
          await r.add(item);
        }
      }
    } else
      await r.addAll(fCMNotification);
  }*/

  Future<void> insertFCMNotification(FCMNotification fCMNotification) async {
    var r = await getFCMNotificationDb();
    await r.add(fCMNotification);
  }
}
