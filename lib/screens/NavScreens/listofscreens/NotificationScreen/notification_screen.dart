import 'package:fire_flutter/api/notification_api.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    title: 'hay kumaran', body: 'its working or not');
              },
              icon: Icon(Icons.notifications),
              label: Text('Simple Notifications')),
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.punch_clock),
              label: Text('Schedule Notifications')),
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.delete),
              label: Text('Remove Notifications')),
        ],
      ),
    );
  }
}
