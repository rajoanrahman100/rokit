import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rokit/utils/styles.dart';

class FirebaseNotifications {
  static FirebaseMessaging _firebaseMessaging;




  static setup(ctx) async {
    _firebaseMessaging = FirebaseMessaging();
    print("calles");

    _firebaseMessaging.getToken().then((token) {
      print("token New::" + token);
    });

    _firebaseMessaging.subscribeToTopic('debug');
    startListener(ctx);
  }

  static startListener(ctx) {
    //if (Platform.isIOS) getApplePermission();


    _firebaseMessaging.configure(

      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _notificationHandler(message, ctx);


      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _notificationHandler(message, ctx);

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _notificationHandler(message, ctx);

      },
    );


  }

  static getApplePermission() {
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered on iOS: $settings");
    });
  }

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  static _notificationHandler(Map<String, dynamic> message, ctx) async {
    print("Local Call");
    print(message.keys);

    var title=message["notification"]["title"];
    var body=message["notification"]["body"];

    print("-----------" + title);

    showNotificationIcon(message, title, body);

  }

  static getData(message, String field) {
    //to fix the bug in firebase_messages
    return Platform.isIOS ? message[field] : message["data"][field];
  }


  static Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }

  }

  static Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {}

  static Future<void> showNotificationIcon(Map<String, dynamic> message, String titleText, String titleTextDetails) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
     flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, titleText, titleTextDetails, platformChannelSpecifics,
        payload: 'Default_Sound');
  }
}
