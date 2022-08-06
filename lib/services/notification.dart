import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificatioService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {},
    );
  }

  void displayNotification() async {
    BigPictureStyleInformation bigPicture = const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher"),
      contentTitle: "Demo image notification",
      summaryText: "This is some text",
      htmlFormatTitle: true,
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'guelfen.hakoudev.music_play.audio',
      'mousika',
      channelDescription: 'local music player ',
      importance: Importance.min,
      priority: Priority.low,
      ticker: 'ticker',
      color: Colors.blue,
      icon: "@mipmap/ic_launcher",
      channelShowBadge: true,
      colorized: true,
      enableLights: true,
      fullScreenIntent: true,
      largeIcon: const FilePathAndroidBitmap("@mipmap/ic_launcher"),
      styleInformation: bigPicture,
      subText: "Playing on this phone",
      tag: "hola",
      additionalFlags: Int32List.fromList(<int>[4]),
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Music title',
      'music artist',
      platformChannelSpecifics,
      payload: 'PLaying now',
    );
  }
}
