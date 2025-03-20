import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'Messaging.dart';
import 'main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationRepository {
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'Channel_id', 'Channel_title',
      description: 'This channel is used for important Notifications',
      importance: Importance.max,
      playSound: true);

//creating Notification channel

  static Future<void> notificationPlugin() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
            AndroidNotificationChannel('001', 'NotiStarti'));

//requesting permission for sending notifications
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

//Android initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
//Action configuration
    Future<void> _showNotificationWithActions() async {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        '...',
        '...',
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction('id_1', 'Action 1'),
          AndroidNotificationAction('id_2', 'Action 2'),
          AndroidNotificationAction('id_3', 'Action 3'),
        ],
      );
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await flutterLocalNotificationsPlugin.show(
          0, '...', '...', notificationDetails);
    }

//Initializing android and iOS settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
//initializing flutter local notifications

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (details) async {
      if (Messaging.openContext != null) {
        Navigator.of(Messaging.openContext!).push(
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              text: details.payload ?? 'No details',
              title: 'Notifications',
            ),
          ),
        );
      }
    });
  }
}
