import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const _kDefaultIcon = 'ic_launcher'; //mipmap/ic_launcher

class NotificationService {
  NotificationService._();

  static final _instance = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(_kDefaultIcon);

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await _instance.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      debugPrint('onSelectNotification payload > $payload');
    });
  }

  static Future<void> showNotification(
      {required String title,
      required String body,
      String? payload,
      required int id,
      int? hour,
      int? minutes}) async {
        
    //! android details
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
            'high_importance_channel', 'high_importance_channel',
            channelDescription: 'high_importance_channel',
            importance: Importance.max,
            priority: Priority.max);

    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    //! show a notification
    await _instance.show(id, title, body, platformChannelSpecifics,
        payload: payload);
  }

  static Future<void> cancelAllNotifications() async {
    _instance.cancelAll();
  }
}
