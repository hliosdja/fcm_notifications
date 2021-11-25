import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHandler {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android, ios);

    await _notifications.initialize(
      settings,
    );
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      AndroidNotificationDetails(
        'notif_id',
        'notifications_app',
        'notif for notifications app',
        importance: Importance.Max,
        priority: Priority.Max,
      ),
      IOSNotificationDetails(),
    );
  }

  static Future showNotifications({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async {
    _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }
}
