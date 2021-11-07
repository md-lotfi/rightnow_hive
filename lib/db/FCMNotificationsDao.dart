import 'package:hive/hive.dart';
import 'package:rightnow/models/fcm_notification.dart';
import 'package:rightnow/models/tag.dart';

class FCMNotificationsDao {
  Future<Box<FCMNotification>> getFCMNotificationDb() async {
    return await Hive.openBox<FCMNotification>('FCMNotification');
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

  Future<void> insertFCMNotifications(List<FCMNotification> fCMNotification) async {
    var r = await getFCMNotificationDb();
    await r.addAll(fCMNotification);
  }

  Future<void> insertFCMNotification(FCMNotification fCMNotification) async {
    var r = await getFCMNotificationDb();
    await r.add(fCMNotification);
  }
}
