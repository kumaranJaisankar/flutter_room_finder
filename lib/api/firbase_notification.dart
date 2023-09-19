import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_flutter/api/notification_api.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/models/user_model.dart';
import 'package:fire_flutter/screens/roomdetail/detail_view.dart';
import 'package:fire_flutter/utils/helperwidgets/helper_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/json_notifi.dart';

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

    Map<String, dynamic> ply = jsonForDetailpage(payLoad);

    Rooms room = Rooms.geoPointJson(ply);

    Get.to(() => RoomDetailScreen(room: room));
  }

  Future initPushMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handelMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handelMessage);
    FirebaseMessaging.onMessage.listen((event) async {
      String? title = event.notification?.title;
      String? body = event.notification?.body;
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final String? fromStore = pref.getString('UserDetail');
      Users userDetail = Users.fromJson(jsonDecode(fromStore!));
      String? userId = userDetail.id;
      final doc = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('notification')
          .doc();
      var docDetails = {
        "id": doc.id,
        "msgReciveTime": DateTime.now(),
        "payload": jsonEncode(event.data),
        "title": title,
        "body": body,
        "isOpend": false,
      };
      await doc.set(docDetails).then((value) => print('added success'));

      NotificationService().showNotification(
          title: title, body: body, payLoad: jsonEncode(event.data));
    });
  }

  Future<void> initNotification() async {
    await _firbaseMessage.requestPermission();
    final fcmToken = await _firbaseMessage.getToken();
    log('fcm token : ${fcmToken.toString()}');
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