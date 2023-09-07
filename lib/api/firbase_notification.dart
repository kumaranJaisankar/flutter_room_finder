import 'dart:convert';
import 'dart:developer';

import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/screens/detailViews/detail_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseNotification {
  final _firbaseMessage = FirebaseMessaging.instance;

  void handelMessage(RemoteMessage? message) {
    if (message == null) return;

    Map<String, dynamic> payLoad = message.data;

    var ply = {
      "imgUrl": payLoad["imgUrl"],
      "isAvalibale": jsonDecode(payLoad["isAvalibale"]),
      "geoLocation": {
        "latitude": jsonDecode(payLoad["geoLocation"])["latitude"],
        "longitude": jsonDecode(payLoad["geoLocation"])["longitude"]
      },
      "price": jsonDecode(payLoad["price"]),
      "rating": jsonDecode(payLoad["rating"]) + 0.0,
      "location": payLoad["location"],
      "id": payLoad["id"],
      "roomName": payLoad["roomName"]
    };
    Rooms room = Rooms.geoPointJson(ply);

    Get.to(() => HeroPage(room: room));
  }

  Future initPushMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
  }

  Future<void> initNotification() async {
    await _firbaseMessage.requestPermission();
    final fcmToken = await _firbaseMessage.getToken();
    log(fcmToken.toString());
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    initPushMessage();
  }
}


// json for detail view

// {
//   "imgUrl":
//       "https://firebasestorage.googleapis.com/v0/b/my-portfolio-fe1ff.appspot.com/o/1bhk-wadala.jpg?alt=media&token=1031fbe9-ff49-4c90-86f7-3e1a1f3ca932",
//   "isAvalibale": true,
//   "geoLocation": {
//     "latitude" :  28.62846608199264,
//     "longitude" : 86.13447944266653
//   },
//   "price": 8000,
//   "rating": 5.0,
//   "location": "Hydrabad",
//   "id": "7tY6L6DWQk2QZbowzGlS",
//   "roomName": "3bhk"
// }