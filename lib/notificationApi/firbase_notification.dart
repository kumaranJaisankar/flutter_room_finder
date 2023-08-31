import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseNotification {
  final _firbaseMessage = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firbaseMessage.requestPermission();
    final fcmToken = await _firbaseMessage.getToken();
    log(fcmToken.toString());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
