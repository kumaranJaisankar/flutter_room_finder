import 'dart:convert';

import 'package:fire_flutter/constants/json_notifi.dart';
import 'package:fire_flutter/models/room_model.dart';
import 'package:fire_flutter/screens/roomdetail/detail_view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings(
            'ic_stat_play_store_512_removebg_preview');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // await notificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse:
    //         (NotificationResponse notificationResponse) async {
    //   print('yes recived');
    // });

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );
  }

  static onSelectNotification(NotificationResponse notificationResponse) async {
    print('getting message');
    String? gettingPayload = notificationResponse.payload;
    print(gettingPayload);

    if (gettingPayload!.isNotEmpty) {
      var decodeJson = jsonDecode(gettingPayload);
      Map<String, dynamic> payloadJson = jsonDecode(gettingPayload);
      bool checkType = decodeJson['isAvalibale'].runtimeType == bool;
      print(checkType);
      print(payloadJson['geoLocation'].runtimeType);

      if (!checkType) {
        Map<String, dynamic> fromRoomModel = jsonForDetailpage(payloadJson);

        Rooms room = Rooms.geoPointJson(fromRoomModel);
        Get.to(() => RoomDetailScreen(room: room));
      } else {
        Rooms room = Rooms.geoPointJson(payloadJson);
        Get.to(() => RoomDetailScreen(room: room));
      }

      // Map<String, dynamic> fromRoomModel = jsonForDetailpage(payloadJson);
    }
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    notificationsPlugin.show(id, title, body, await notificationDetails(),
        payload: payLoad);
  }

  void showScheduledNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduleTime}) async {
    notificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(scheduleTime, tz.local), await notificationDetails(),
        payload: payLoad,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }
}
