import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static _notificationsDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          "channel id", "channel name", "channel description",
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static void showScheduledNotifications(
      {int? id = 0,
      String? title,
      String? body,
      String? payload,
      required dateTime}) async {
    _notifications.zonedSchedule(
        id!,
        title,
        body,
        dateTime,
        _notificationsDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
