import 'dart:convert';

import 'package:fire_flutter/api/notification_api.dart';
import 'package:flutter/material.dart';

class NotificationTesting extends StatelessWidget {
  const NotificationTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NOTIFICATION',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  NotificationService().showNotification(
                    title: 'hay kumaran',
                    body: 'its working or not',
                  );
                },
                icon: Icon(Icons.notifications),
                label: Text('Simple Notifications')),
            ElevatedButton.icon(
                onPressed: () {
                  var payload = {
                    "imgUrl":
                        "https://firebasestorage.googleapis.com/v0/b/my-portfolio-fe1ff.appspot.com/o/1bhk-wadala.jpg?alt=media&token=1031fbe9-ff49-4c90-86f7-3e1a1f3ca932",
                    "isAvalibale": true,
                    "geoLocation": {
                      "latitude": 28.62846608199264,
                      "longitude": 86.13447944266653
                    },
                    "price": 8000,
                    "rating": 5.0,
                    "location": "Hydrabad",
                    "id": "7tY6L6DWQk2QZbowzGlS",
                    "roomName": "3bhk"
                  };
                  NotificationService().showScheduledNotification(
                      id: 2,
                      title: "Now home available!",
                      body:
                          "hey Krishna, now 3BHK home is available, plz check it🎁",
                      payLoad: jsonEncode(payload),
                      scheduleTime: DateTime.now().add(Duration(seconds: 10)));
                  final snackBar = SnackBar(
                    content: Text('message will get after 10 sec'),
                    backgroundColor: Colors.green.withOpacity(0.3),
                    showCloseIcon: true,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  // Get.snackbar('Scheduled', "message will recive after 10sec",
                  //     snackPosition: SnackPosition.BOTTOM,
                  //     snackStyle: SnackStyle.GROUNDED,
                  //     colorText: Colors.black);
                },
                icon: Icon(Icons.punch_clock),
                label: Text('Schedule Notifications')),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.delete),
                label: Text('Remove Notifications')),
          ],
        ),
      ),
    );
  }
}
